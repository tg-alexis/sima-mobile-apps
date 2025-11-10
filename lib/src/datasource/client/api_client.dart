import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/common.dart';
import '../../features/features.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/api/v2/auth/login")
  Future<DataResponse<UserTokenModel>> login(@Body() UserModel body);

  @POST("/api/v2/attendees/check-access")
  Future<DataResponse<AttendeeModel>> checkAccess(@Body() AttendeeModel body);

  @POST("/api/v2/users")
  Future<DataResponse<UserModel>> createUser(@Body() UserModel body);

  @GET("/api/v2/auth/me")
  Future<DataResponse<UserModel>> userInfos();

  @GET("/api/v2/events")
  Future<DataResponse<ListEventModel>> getEvents();

  @GET("/api/v2/profiles")
  Future<DataResponse<Profile>> getProfiles();

  @GET("/api/v2/users?all=true")
  Future<DataResponse<ListUserModel>> getUsers();

}
