import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../datasource/datasource.dart';
import '../auth.dart';

final authControllerProvider = ChangeNotifierProvider((ref) => AuthController());

class AuthController extends ChangeNotifier {
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();
  UserModel? _userModel;
  String? _errorMessage;
  List<Profile> _profiles = [];
  List<UserModel> _users = [];

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

  Future<bool> createUser(UserModel body) async {
    bool statusResponse = false;
    _errorMessage = null;
    notifyListeners();

    var response = await _authRepository.createUser(body);

    response.when(
      failure: (String? message) {},
      onItem: (item) {
        statusResponse = true;
        getUsers();
      },
    );

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

  Future<void> getProfiles() async {
    if (_profiles.isNotEmpty) return;

    _errorMessage = null;
    notifyListeners();

    var response = await _authRepository.getProfiles();

    response.when(
      onItems: (items) {
        _profiles = items;
      },
      failure: (String? message) {
        _errorMessage = message;
      },
    );

    notifyListeners();
  }

  Future<void> getUsers() async {
    _errorMessage = null;
    notifyListeners();

    var response = await _authRepository.getUsers();

    response.when(
      onItem: (item) {
        _users = item.result ?? [];
      },
      failure: (String? message) {
        _errorMessage = message;
      },
    );

    notifyListeners();
  }

  void logout() async {
    _userModel = null;
    notifyListeners();
  }

  UserModel? get user => _userModel;

  String? get errorMessage => _errorMessage;

  List<UserModel> get users => _users;

  List<Profile> get profiles => _profiles;
}
