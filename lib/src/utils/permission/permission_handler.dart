import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission setting) async {
  // setting.request() will return the status ALWAYS
  // if setting is already requested, it will return the status
  final result = await setting.request();
  if (kDebugMode) {
    print("requestPermission => $result");
  }
  switch (result) {
    case PermissionStatus.granted:
    case PermissionStatus.limited:
    case PermissionStatus.provisional:
      return true;
    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.permanentlyDenied:
      return false;
  }
}

Future<bool> statusPermission(Permission setting) async {
  // setting.request() will return the status ALWAYS
  // if setting is already requested, it will return the status
  final result = await setting.status;
  debugPrint("statusPermission => $result");
  if (kDebugMode) {
    print("statusPermission => $result");
  }
  switch (result) {
    case PermissionStatus.granted:
    case PermissionStatus.limited:
    case PermissionStatus.provisional:
      return true;
    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.permanentlyDenied:
      return false;
  }
}
