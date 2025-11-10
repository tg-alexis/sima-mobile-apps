import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets.dart';

class MediumText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final Color? decorationColor;
  final double? fontSize;
  final int? maxLines;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;

  const MediumText(
    this.text, {
    super.key,
    this.textStyle,
    this.color,
    this.fontSize,
    this.maxLines,
    this.decoration,
    this.fontWeight,
    this.textOverflow,
    this.textAlign,
    this.decorationColor,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BasicText(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      textStyle:
          textStyle ??
          TextStyle(
            color: color,
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.w500,
            decoration: decoration,
            overflow: textOverflow,
            decorationColor: decorationColor,
            fontStyle: fontStyle,
          ),
    );
  }
}
