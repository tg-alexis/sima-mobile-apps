import 'package:flutter/material.dart';

import '../../../styles/styles.dart';
import '../widgets.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final double? height;
  final Gradient gradient;
  final TextOverflow? overflow;

  const GradientText(
    this.text,
    this.gradient, {
    super.key,
    this.textStyle,
    this.textAlign,
    this.color,
    this.fontSize,
    this.decoration,
    this.maxLines,
    this.fontWeight,
    this.height,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: BasicText(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        textStyle: textStyle ?? TextStyle(fontSize: fontSize, decoration: decoration, overflow: overflow, fontWeight: fontWeight, height: height),
      ),
    );
  }
}
