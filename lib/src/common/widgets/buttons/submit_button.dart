import 'package:flutter/material.dart';

import '../../../styles/colors/colors.dart';
import '../widgets.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final Color? iconColor;
  final Function? onTap;
  final bool isEnabled;
  final IconData? icon;
  final EdgeInsets? padding;
  final bool? showToLeft;
  final bool? showToRight;

  const SubmitButton({
    super.key,
    required this.text,
    this.textColor,
    this.onTap,
    this.isEnabled = true,
    this.color,
    this.borderColor,
    this.icon,
    this.iconColor,
    this.padding,
    this.showToLeft,
    this.showToRight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BasicButton(
            text: text,
            borderColor: borderColor,
            icon: icon,
            padding: padding,
            iconColor: iconColor,
            showToLeft: showToLeft,
            showToRight: showToRight,
            isEnabled: isEnabled,
            onTap: () {
              if (isEnabled) {
                if (onTap != null) onTap!();
              }
            },
            color: color ?? AppColors.primaryColor,
            textColor: textColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
