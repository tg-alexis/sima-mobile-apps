import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../styles/styles.dart';
import '../widgets.dart';

class BodyText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final double? height;
  final TextOverflow? overflow;

  const BodyText(this.text, {super.key, this.textStyle, this.textAlign, this.color, this.fontSize, this.decoration, this.maxLines, this.fontWeight, this.height, this.overflow});

  @override
  Widget build(BuildContext context) {
    return BasicText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      textStyle: textStyle ??
          TextStyle(
            color: color,
            fontSize: fontSize ?? 16.sp,
            decoration: decoration,
            fontWeight: fontWeight,
            overflow: overflow,
            height: height,
          ),
    );
  }
}
