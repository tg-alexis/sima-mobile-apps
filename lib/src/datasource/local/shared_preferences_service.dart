import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/features.dart';

class SharedPreferencesService {
  static SharedPreferences? _sharedPreferences;

  static Future getInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static void saveToken(String? token) async {
    if (token == null) return;
    await getInstance();
    _sharedPreferences?.setString('token', token);
  }

  static void saveRefreshToken(String? token) async {
    if (token == null) return;
    await getInstance();
    _sharedPreferences?.setString('refresh_token', token);
  }

  static void saveUser(UserModel user) async {
    await getInstance();
    _sharedPreferences?.setString("user", json.encode(user));
  }

  static Future<UserModel?> getUser() async {
    await getInstance();
    var data = _sharedPreferences?.getString("user");
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  static Future<String?> getToken() async {
    await getInstance();
    var data = _sharedPreferences?.getString('token');
    return data;
  }

  static Future<String?> getRefreshToken() async {
    await getInstance();
    var data = _sharedPreferences?.getString('refresh_token');
    return data;
  }

  static void clearAll() async {
    await getInstance();
    _sharedPreferences?.clear();
  }
}
