import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../styles/styles.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class InputForm extends StatelessWidget {
  final Widget child;
  final String? text;
  final double? height;
  final bool showIsRequired;
  final bool isRequired;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const InputForm({super.key, required this.child, this.text, this.textColor, this.backgroundColor, this.height, this.padding, this.showIsRequired = true, this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (text != null)
          Padding(
            padding: EdgeInsets.only(left: SizerHelper.w(1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: text,
                    style: TextStyle(color: textColor ?? Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: showIsRequired
                            ? isRequired
                                  ? ' *'
                                  : ""
                            : "",
                        style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Spacers.sw2,
              ],
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(SizerHelper.w(3))),
            border: Border.all(color: AppColors.greyColor),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.only(left: SizerHelper.w(2)),
            child: child,
          ),
        ),
        Spacers.sw2,
      ],
    );
  }
}
