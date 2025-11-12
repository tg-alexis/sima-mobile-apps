import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common/common.dart';
import '../../event/event_bus.dart';
import '../../features/auth/auth.dart';
import '../datasource.dart';

class ApiClientInstance {
  static ApiClient? _apiClient;

  static late Dio _dio;
  static bool _isRefreshing = false;

  static Future<void> init({bool allowSelfSigned = true}) async {
    _dio = Dio();

    // Gestion SSL (DEV uniquement avec allowSelfSigned)
    if (allowSelfSigned) {
      final adapter = IOHttpClientAdapter();

      adapter.createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      _dio.httpClientAdapter = adapter;
    }

    await setupDioClient();
  }

  static Future<void> setupDioClient() async {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        logPrint: (o) => log(o.toString()),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach token if available
          var token = await SharedPreferencesService.getToken();
          var refreshToken = await SharedPreferencesService.getRefreshToken();
          if (token != null) {
            options.path.contains('/refresh-token')
                ? options.headers["Authorization"] = "Bearer $refreshToken"
                : options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.requestOptions.path.contains('/refresh-token')) {
            EventBusInstance.instance.fire(LogoutEvent());
            return handler.reject(error);
          }

          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            try {
              final responseData = error.response?.data;
              final message = responseData is Map<String, dynamic>
                  ? responseData['message']?.toString()
                  : null;

              // Messages d'erreurs liées au token qui nécessitent un refresh
              final tokenExpiredMessages = [
                'Token expiré',
                'Token expired',
                'jwt expired',
                'Token invalide',
                'Invalid token',
                'Token JWT expiré',
                'Unauthorized',
                'Token JWT expiré. Veuillez vous reconnecter',
              ];

              final shouldRefreshToken =
                  tokenExpiredMessages.any(
                    (msg) =>
                        message?.toLowerCase().contains(msg.toLowerCase()) ==
                        true,
                  ) &&
                  !_isRefreshing &&
                  error.response?.statusCode == 401;

              if (shouldRefreshToken) {
                _isRefreshing = true;
                try {
                  var refreshToken =
                      await SharedPreferencesService.getRefreshToken();
                  if (refreshToken == null) {
                    EventBusInstance.instance.fire(LogoutEvent());
                    _isRefreshing = false;
                    return handler.reject(error);
                  }

                  // Tenter de rafraîchir le token
                  final refreshResponse = await _dio.post(
                    '${ApiClientConstant.apiBaseUrl}/refresh-token',
                    options: Options(
                      headers: {'Authorization': 'Bearer $refreshToken'},
                    ),
                  );

                  if (refreshResponse.statusCode == 200) {
                    final newToken = UserTokenModel.fromJson(
                      refreshResponse.data,
                    );
                    SharedPreferencesService.saveToken(newToken.accessToken);
                    SharedPreferencesService.saveRefreshToken(
                      newToken.refreshToken,
                    );

                    final originalRequest = error.requestOptions;
                    final newAccessToken =
                        await SharedPreferencesService.getToken();
                    if (newAccessToken != null) {
                      originalRequest.headers['Authorization'] =
                          'Bearer $newAccessToken';

                      // Relancer la requête originale
                      final retryResponse = await _dio.fetch(originalRequest);
                      _isRefreshing = false;
                      return handler.resolve(retryResponse);
                    }
                  }
                } catch (e) {
                  EventBusInstance.instance.fire(LogoutEvent());
                  _isRefreshing = false;
                  return handler.reject(error);
                }
              } else {
                // Si c'est une erreur de login, ne pas déclencher le logout
                // et renvoyer un message générique
                if (error.requestOptions.path.contains('/auth/login')) {
                  final customError = DioException(
                    requestOptions: error.requestOptions,
                    response: Response(
                      requestOptions: error.requestOptions,
                      statusCode: 401,
                      data: {
                        'message':
                            'Identifiants incorrects. Veuillez vérifier votre email et mot de passe.',
                      },
                    ),
                    type: error.type,
                  );
                  return handler.reject(customError);
                }

                // Pour les autres erreurs 401/403, déclencher le logout
                EventBusInstance.instance.fire(LogoutEvent());
                _isRefreshing = false;
                return handler.reject(error);
              }
            } catch (e) {
              EventBusInstance.instance.fire(LogoutEvent());
              _isRefreshing = false;
              return handler.reject(error);
            }
          }
          return handler.reject(error);
        },
        onResponse: (response, handler) {
          return handler.resolve(response);
        },
      ),
    );

    _apiClient = ApiClient(_dio, baseUrl: ApiClientConstant.apiBaseUrl);
  }

  static ApiClient get instance => _apiClient!;
}
