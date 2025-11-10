import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../styles/styles.dart';

class BasicTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? text;
  final bool? readOnly;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final bool? showIconToClear;
  final bool? nextInputForm;
  final bool? enableInteractiveSelection;
  final bool obscureText;
  final FocusNode? focusNode;
  final Color? textColor;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final double? fontSize;
  final TextCapitalization? textCapitalization;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String value)? onChanged;
  final Function()? onEditingComplete;
  final Function(String value)? onEditingCompleted;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final Function()? onTap;
  final String? validatorValue;
  final EdgeInsets? padding;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final double? height;
  final int? minLines;
  final int? maxLines;


  const BasicTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.text,
      this.readOnly,
      this.controller,
      this.textInputType,
      this.textAlign,
      this.showIconToClear,
      this.nextInputForm,
      this.enableInteractiveSelection,
      this.obscureText = false,
      this.focusNode,
      this.textColor,
      this.backgroundColor,
      this.inputFormatters,
      this.maxLength,
      this.textCapitalization,
      this.prefix,
      this.suffix,
      this.onChanged,
      this.onEditingComplete,
      this.onEditingCompleted,
      this.onFieldSubmitted,
      this.onTap,
      this.validatorValue,
      this.padding,
      this.validator, this.fontSize, this.textAlignVertical, this.expands, this.height, this.minLines, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        keyboardType: textInputType,
        enableInteractiveSelection: enableInteractiveSelection ?? true,
        readOnly: readOnly ?? false,
        controller: controller,
        obscureText: obscureText,
        textInputAction: nextInputForm == true ? TextInputAction.next : null,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        onTap: onTap,
        validator: validator,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(fontSize: fontSize ?? 15, color: textColor, fontWeight: FontWeight.w500),
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        focusNode: focusNode,
        textAlignVertical: textAlignVertical,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: prefix,
          border: InputBorder.none,
          labelText: labelText,
          hintText: hintText,
          errorText: "",
          helperText: "",
          helperStyle: TextStyle(fontSize: 0),
          errorStyle: TextStyle(fontSize: 0),
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: fontSize ?? 15.sp,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: fontSize ?? 15.sp,
          ),
        ),
      ),
    );
  }
}
