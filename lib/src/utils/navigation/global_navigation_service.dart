import 'package:flutter/material.dart';

import '../../features/auth/auth.dart';
import '../../utils/utils.dart';

class GlobalNavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static void navigateToLogin() {
    if (navigator != null) {
      NavigationUtil.pushAndRemoveUntil(
        navigator!.context,
        const LoginScreen(),
      );
    }
  }
}
