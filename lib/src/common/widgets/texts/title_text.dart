import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../styles/styles.dart';
import '../widgets.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;

  const TitleText(this.text, {super.key, this.textStyle, this.color, this.fontSize, this.maxLines, this.decoration, this.textOverflow, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      textStyle: textStyle ?? TextStyle(color: color, fontSize: fontSize ?? 16.sp, decoration: decoration, overflow: textOverflow, fontWeight: FontWeight.w700),
    );
  }
}
