import 'package:flutter/material.dart';

import '../../utils.dart';

class NavigationUtil {
  static Future<dynamic> push(BuildContext context, Widget page, {MaterialPageRoute? route}) {
    return Navigator.push(context, route ?? SlideLeftRoute(builder: (_) => page));
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget page, {MaterialPageRoute? route}) {
    return Navigator.pushReplacement(context, route ?? SlideLeftRoute(builder: (_) => page));
  }

  static Future<dynamic> pushAndRemoveUntil(BuildContext context, Widget page, {MaterialPageRoute? route}) {
    return Navigator.pushAndRemoveUntil(
      context,
      route ?? SlideLeftRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
