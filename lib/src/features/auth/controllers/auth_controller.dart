import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../datasource/datasource.dart';
import '../auth.dart';

final authControllerProvider = ChangeNotifierProvider((ref) => AuthController());

class AuthController extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();
  UserModel? _userModel;
  String? _errorMessage;

  Future<void> checkUserLoggedIn() async {
    _userModel ??= await SharedPreferencesService.getUser();
    notifyListeners();
  }

  Future<bool> login({required String login, required String password}) async {
    bool statusResponse = false;
    _errorMessage = null;
    notifyListeners();

    var response = await _authRepository.login(UserModel(email: login, password: password));

    if (response.error == true) {
      _errorMessage = response.message;
      statusResponse = false;
    } else {
      statusResponse = await _getUserInfos();
    }

    notifyListeners();

    return statusResponse;
  }

  Future<bool> _getUserInfos() async {
    bool statusResponse = false;
    _errorMessage = null;
    notifyListeners();

    var response = await _authRepository.getUserInfos();

    response.when(
      onItem: (item) {
        statusResponse = true;
      },
      failure: (String? message) {
        _errorMessage = message;
      },
    );

    await checkUserLoggedIn();

    notifyListeners();

    return statusResponse;
  }

  void logout() async {
    _userModel = null;
    notifyListeners();
  }

  UserModel? get user => _userModel;

  String? get errorMessage => _errorMessage;
}
