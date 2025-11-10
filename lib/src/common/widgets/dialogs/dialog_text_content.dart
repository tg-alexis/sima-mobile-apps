import 'package:flutter/material.dart';

import '../widgets.dart';

class DialogTextContent extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function defaultCallback;
  final Function? sideCallback;
  final String? defaultButtonText;
  final String? sideButtonText;
  final bool isError;

  const DialogTextContent({super.key, 
    required this.text,
    this.icon,
    required this.defaultCallback,
    this.defaultButtonText = "OK",
    this.sideCallback,
    this.sideButtonText,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return DialogContent(
      icon: icon,
      defaultButtonText: defaultButtonText,
      defaultCallback: defaultCallback,
      sideCallback: sideCallback,
      sideButtonText: sideButtonText,
      isError: isError,
      content: MediumText(
        text,
        textAlign: TextAlign.center,
        maxLines: 5,
      ),
    );
  }
}
