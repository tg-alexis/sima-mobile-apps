import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../common/common.dart';
import '../../event/event_bus.dart';
import '../datasource.dart';

class ApiClientInstance {
  static ApiClient? _apiClient;

  static late Dio _dio;

  static Future<void> init({bool allowSelfSigned = true}) async {
    _dio = Dio();

    // Gestion SSL (DEV uniquement avec allowSelfSigned)
    if (allowSelfSigned) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    await setupDioClient();
  }

  static Future<void> setupDioClient() async{
    _dio.interceptors.add(PrettyDioLogger(requestBody: true, requestHeader: true, responseBody: true, logPrint: (o) => log(o.toString())));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          // Attach token if available
          var token = await SharedPreferencesService.getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (error, handler) async {


          if (error.response?.statusCode == 401) {
            EventBusInstance.instance.fire(LogoutEvent());
          }

          return handler.reject(error);

          // // Check if error is 401 (Unauthorized)
          // if (error.response?.statusCode == 401) {
          //   final requestOptions = error.requestOptions;
          //
          //   if (requestOptions.uri.path.contains("sign-in")) {
          //     return handler.reject(error);
          //   }
          //
          //   // Prevent infinite loop: check if it's already a retry
          //   final isRetry = requestOptions.headers['x-retry'] == true;
          //   if (!isRetry) {
          //     try {
          //       // var refreshToken = await SharedPreferencesService.getRefreshToken();
          //       // // Attempt token refresh
          //       // DataResponse<UserTokenModel> userToken = await ApiClientInstance.instance.refreshToken(UserTokenModel(refreshToken: refreshToken));
          //       // if (userToken.item != null) {
          //       //   // Save new token
          //       //   SharedPreferencesService.saveToken(userToken.item!.accessToken!);
          //       //   SharedPreferencesService.saveRefreshToken(userToken.item!.refreshToken!);
          //       //
          //       //   // Update headers with new token and mark as retry
          //       //   requestOptions.headers["Authorization"] = "Bearer ${userToken.item!.accessToken!}";
          //       //   requestOptions.headers["x-retry"] = true;
          //       //
          //       //   // Retry the original request
          //       //   final response = await _dio.fetch(requestOptions);
          //       //   return handler.resolve(response);
          //       // }
          //     } catch (e) {
          //       return handler.reject(error);
          //     }
          //   }
          // }
          //
          // // Optional: handle 400 error
          // if (error.response?.statusCode == 400) {
          //   return handler.resolve(error.response!);
          // }
          //
          // return handler.reject(error);
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
