import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class MessageError{

  static String getMessageFromException(Exception e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.unknown) {
        return "Vérifiez votre connexion internet et réessayez.";
      }
    }

    if (e is SocketException) {
      return "Vérifiez votre connexion internet et réessayez.";
    }
    if (e is TimeoutException) {
      return "Service momentanément indisponible. Réessayez plus tard.";
    }

    return "Désolé, nous n'arrivons pas à traiter votre demande !\nVeuillez réessayer plus tard";
  }

}