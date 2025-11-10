import 'package:dio/dio.dart';

import '../../../common/common.dart';
import '../../../datasource/datasource.dart';
import '../../../utils/utils.dart';
import '../event.dart';

class EventRepositoryImpl {
  Future<DataResponse<ListEventModel>> getEvents() async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.getEvents();

      return response;
    } on DioException catch (e) {
      try {
        return DataResponse.failure("${e.response?.data?['message'] ?? e.message}");
      } catch (e) {
        return DataResponse.failure("Service non disponible ! Veuillez réessayer plus tard");
      }
    }
  }

  Future<DataResponse<AttendeeModel>> checkAccess({required int eventId, required String attendeeId}) async {
    try {
      bool hasConnection = await checkNetwork();
      if (!hasConnection) {
        return DataResponse.failure("Veuillez vérifier votre connexion internet.");
      }

      var response = await ApiClientInstance.instance.checkAccess(AttendeeModel(attendeeId: attendeeId, eventId: eventId));

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
