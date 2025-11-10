import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/common.dart';
import '../../datasource/datasource.dart';
// import '../../features/features.dart';
import '../utils.dart';

class AppExtension {
  static void signOut(BuildContext context) {
    Modals.showBottomModal(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BodyText("Vous êtes sur le point de vous déconnecter! Confirmez-vous ?", textAlign: TextAlign.center,),
          Spacers.sw8,
          SubmitButton(text: "Deconnexion", color: Color(0xFFF06868), textColor: Colors.white, onTap: (){
            SharedPreferencesService.clearAll();
            // NavigationUtil.pushAndRemoveUntil(context, const LoginScreen());
          },),
          Spacers.min,
          SubmitButton(text: "Annuler", color: Colors.white, textColor: Colors.black, onTap: ()=> NavigationUtil.pop(context),),
        ],
      ),
    );
  }

  static unFocus(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<String?> get playerId async {
    // String? playerId = await OneSignal.User.getOnesignalId();
    return "";
  }

  static Future<void> clearAppCache() async {
    // try {
    //   final cacheDir = await getTemporaryDirectory();
    //
    //   if (cacheDir.existsSync()) {
    //     cacheDir.deleteSync(recursive: true);
    //   }
    //
    //   debugPrint('App cache cleared successfully.');
    // } catch (e) {
    //   debugPrint('Error clearing app cache: $e');
    // }
  }
}
