import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../styles/colors/colors.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class Dialogs {
  static Future showLoadingDialog(BuildContext context, {String? message, bool dismissible = false}) async {
    message ??= 'Chargement en cours...';

    return showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizerHelper.w(4),
              ),
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacers.medium,
              SpinKitRing(
                lineWidth: SizerHelper.w(1),
                color: AppColors.primaryColor,
                size: SizerHelper.w(10),
              ),
              Spacers.sw6,
              BodyText(
                message!,
                decoration: TextDecoration.none,
              ),
              Spacers.medium,
            ],
          ),
        );
      },
    );
  }

  static void displayInfoDialog(BuildContext context, {required String text, Function? callback, IconData? icon, bool isError = false}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizerHelper.w(4),
                ),
              ),
            ),
            content: DialogTextContent(
              isError: isError,
              text: text,
              defaultCallback: callback ?? () {},
              icon: icon,
            ));
      },
    );
  }

  static void displayWidgetDialog(BuildContext context, {required Widget child}) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizerHelper.w(4),
                ),
              ),
            ),
            content: child);
      },
    );
  }

  static void displayActionDialog(BuildContext context,
      {required Function callback, required Function sideCallback, required String title, IconData? icon, String? callbackText, String? sideCallbackText}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizerHelper.w(3),
                ),
              ),
            ),
            content: DialogTextContent(
              text: title,
              defaultCallback: callback,
              defaultButtonText: callbackText ?? "Oui",
              sideCallback: sideCallback,
              sideButtonText: sideCallbackText ?? "Non",
              icon: icon,
            ));
      },
    );
  }

  static Future showBlurDialog(
    BuildContext context, {
    required Widget content,
    double sigmaX = 1,
    double sigmaY = 1,
    Color? color,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: content,
        );
      },
    );
  }
}
