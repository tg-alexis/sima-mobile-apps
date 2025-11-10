import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final int? maxLines;
  final TextAlign? textAlign;

  const BasicText(this.text, {super.key, required this.textStyle, this.maxLines, this.textAlign,});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      style: textStyle,
    );
  }
}
