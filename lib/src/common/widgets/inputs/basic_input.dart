import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets.dart';

class BasicInput extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? text;
  final bool? readOnly;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final bool? nextInputForm;
  final bool? obscureText;
  final bool? showIconToClear;
  final FocusNode? focusNode;
  final Color? textColor;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String value)? onEditingCompleted;
  final String? validator;
  final Function()? onTap;
  final Widget? suffix;
  final Widget? prefix;
  final bool? isRequired;
  final bool? showError;
  final bool? enableInteractiveSelection;
  final EdgeInsets? padding;
  final TextAlignVertical? textAlignVertical;
  final bool showIsRequired;


  const BasicInput(this.controller,
      {super.key,
      this.hintText,
      this.labelText,
      this.readOnly,
      this.textInputType,
      this.textAlign,
      this.nextInputForm,
      this.text,
      this.obscureText,
      this.backgroundColor,
      this.focusNode,
      this.textColor,
      this.inputFormatters,
      this.textCapitalization,
      this.showIconToClear,
      this.onChanged,
      this.maxLength, this.onTap, this.onEditingComplete, this.onFieldSubmitted, this.onEditingCompleted, this.validator, this.suffix, this.prefix, this.isRequired, this.enableInteractiveSelection, this.padding, this.textAlignVertical, this.showError, this.showIsRequired = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BasicTextForm(
        showIsRequired: showIsRequired,
          textInputType: textInputType,
          readOnly: readOnly ?? false,
          controller: controller,
          obscureText: obscureText ?? false,
          nextInputForm: nextInputForm,
          textAlign: textAlign ?? TextAlign.start,
          maxLength: maxLength,
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          labelText: labelText,
          textColor: textColor,
          hintText: hintText,
          textAlignVertical: textAlignVertical,
          text: text,
          validator: validator,
          onChanged: onChanged,
          suffix: suffix,
          prefix: prefix,
          backgroundColor: backgroundColor,
          isRequired: isRequired ?? true,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          onEditingCompleted: onEditingCompleted,
          enableInteractiveSelection: enableInteractiveSelection,
          showError: showError ?? true,
          padding: padding,
          onTap: onTap,
          showIconToClear: showIconToClear),
    );
  }
}
