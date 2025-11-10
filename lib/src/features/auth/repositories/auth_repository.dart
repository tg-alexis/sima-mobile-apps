import 'package:dio/dio.dart';

import '../../../common/common.dart';
import '../../../datasource/datasource.dart';
import '../../../utils/utils.dart';
import '../auth.dart';

class AuthRepositoryImpl {
  Future<DataResponse<UserTokenModel>> login(UserModel body) async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.login(body);

      SharedPreferencesService.saveToken(response.item?.accessToken);
      SharedPreferencesService.saveRefreshToken(response.item?.refreshToken);

      return response;
    } on DioException catch (e) {
      try {
        return DataResponse.failure("${e.response?.data?['message'] ?? e.message}");
      } catch (e) {
        return DataResponse.failure("Service non disponible ! Veuillez réessayer plus tard");
      }
    }
  }

  Future<DataResponse<UserModel>> createUser(UserModel body) async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.createUser(body);


      return response;
    } on DioException catch (e) {
      try {
        return DataResponse.failure("${e.response?.data?['message'] ?? e.message}");
      } catch (e) {
        return DataResponse.failure("Service non disponible ! Veuillez réessayer plus tard");
      }
    }
  }

  Future<DataResponse<UserModel>> getUserInfos() async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.userInfos();

      if (response.item != null) SharedPreferencesService.saveUser(response.item!);

      return response;
    } on DioException catch (e) {
      try {
        return DataResponse.failure("${e.response?.data?['message'] ?? e.message}");
      } catch (e) {
        return DataResponse.failure("Service non disponible ! Veuillez réessayer plus tard");
      }
    }
  }

  Future<DataResponse<Profile>> getProfiles() async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.getProfiles();


      return response;
    } on DioException catch (e) {
      try {
        return DataResponse.failure("${e.response?.data?['message'] ?? e.message}");
      } catch (e) {
        return DataResponse.failure("Service non disponible ! Veuillez réessayer plus tard");
      }
    }
  }

  Future<DataResponse<ListUserModel>> getUsers() async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.getUsers();


      return response;
    } on DioException catch (e) {
      try {
        return DataResponse.failure("${e.response?.data?['message'] ?? e.message}");
      } catch (e) {
        return DataResponse.failure("Service non disponible ! Veuillez réessayer plus tard");
      }
    }
  }
}
