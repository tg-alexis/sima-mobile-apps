import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/features.dart';

class SharedPreferencesService {
  static SharedPreferences? _sharedPreferences;

  static Future getInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String? token) async {
    if (token == null) return;
    await getInstance();
    await _sharedPreferences?.setString('token', token);
  }

  static Future<void> saveRefreshToken(String? token) async {
    if (token == null) return;
    await getInstance();
    await _sharedPreferences?.setString('refresh_token', token);
  }

  static Future<void> saveUser(UserModel user) async {
    await getInstance();
    await _sharedPreferences?.setString("user", json.encode(user));
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

  static Future<void> clearAll() async {
    await getInstance();
    await _sharedPreferences?.clear();
  }
}
