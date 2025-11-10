import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../widgets.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? iconColor;
  final Function onTap;
  final EdgeInsets? padding;
  final double? fontSize;
  final IconData? icon;
  final bool? showToLeft;
  final bool? showToRight;
  final bool isEnabled;

  const BasicButton({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    required this.onTap,
    this.borderColor,
    this.padding,
    this.fontSize,
    this.icon,
    this.iconColor,
    this.showToLeft = true,
    this.showToRight = true,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (icon == null && showToLeft == true ||
        icon == null && showToRight == true) {
      throw Exception(
        "icon can't be null when showToLeft or showToRight is true",
      );
    }

    if (showToLeft == true && showToRight == true) {
      throw Exception(
        "showToLeft and showToRight can't be true at the same time",
      );
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: isEnabled ? color : color?.withValues(alpha: 0.3),
          border: borderColor == null ? null : Border.all(color: borderColor!),
          borderRadius: BorderRadius.all(Radius.circular(SizerHelper.w(3))),
        ),
        padding: padding ?? EdgeInsets.all(SizerHelper.w(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && showToLeft == true) ...{
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: SizerHelper.w(5),
              ),
              Spacers.sw3,
            },
            TitleText(
              text,
              textAlign: TextAlign.center,
              color: textColor,
              fontSize: fontSize,
            ),
            if (icon != null && showToRight == true) ...{
              Spacers.sw3,
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: SizerHelper.w(5),
              ),
            },
          ],
        ),
      ),
    );
  }
}
