import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../styles/styles.dart';
import '../../../utils/utils.dart';
import '../../common.dart';

class BasicTextForm extends StatefulWidget {
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
  final TextCapitalization? textCapitalization;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String value)? onChanged;
  final Function()? onEditingComplete;
  final Function(String value)? onEditingCompleted;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final String? validator;
  final bool isRequired;
  final EdgeInsets? padding;
  final bool showError;
  final TextAlignVertical? textAlignVertical;
  final double? height;
  final bool showIsRequired;
  final int? maxLines;
  final int? minLines;

  const BasicTextForm({
    super.key,
    this.labelText,
    this.backgroundColor,
    this.text,
    this.readOnly,
    this.showIconToClear,
    this.controller,
    this.textInputType,
    this.textAlign,
    this.nextInputForm,
    this.obscureText = false,
    this.focusNode,
    this.textColor,
    this.enableInteractiveSelection,
    this.inputFormatters,
    this.maxLength,
    this.textCapitalization,
    this.onChanged,
    this.onTap,
    this.hintText,
    this.prefix,
    this.suffix,
    this.validator,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onEditingCompleted,
    this.isRequired = true,
    this.showError = true,
    this.padding,
    this.textAlignVertical,
    this.height,
    this.maxLines,
    this.minLines,
    this.showIsRequired = true,
  });

  @override
  State<BasicTextForm> createState() => _BasicTextFormState();
}

class _BasicTextFormState extends State<BasicTextForm> {
  Timer? _checkTypingTimer;
  String? _errorMessage;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onChangeValue);
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onChangeValue);
    _checkTypingTimer?.cancel();
    _focusNode.removeListener(_onFocusChange);

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.text != null)
          Padding(
            padding: EdgeInsets.only(left: SizerHelper.w(1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: widget.text,
                    style: TextStyle(color: widget.textColor ?? Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: widget.showIsRequired
                            ? widget.isRequired
                                  ? ' *'
                                  : ""
                            : "",
                        style: TextStyle(color: Colors.red, fontSize: 15.sp, fontWeight: FontWeight.w400),
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
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(SizerHelper.w(3))),
            border: Border.all(
              color: widget.isRequired
                  ? _errorMessage != null
                        ? Colors.red
                        : _focusNode.hasFocus
                        ? AppColors.primaryColor
                        : Colors.grey
                  : Colors.grey,
            ),
          ),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.only(left: SizerHelper.w(2)),
            child: BasicTextFormField(
              height: widget.height,
              suffix: widget.suffix,
              prefix: widget.prefix,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              textInputType: widget.textInputType,
              enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
              readOnly: widget.readOnly ?? false,
              controller: widget.controller,
              backgroundColor: Colors.white,
              obscureText: widget.obscureText,
              nextInputForm: widget.nextInputForm,
              textAlign: widget.textAlign ?? TextAlign.start,
              maxLength: widget.maxLength,
              textAlignVertical: widget.textAlignVertical,
              onTap: widget.onTap,
              validator: (value) {
                if (TextInputType.emailAddress == widget.textInputType) {
                  if (value!.isValidEmail() == false) {
                    _errorMessage = "Email incorrect";
                    setState(() {});
                  }
                }

                if (widget.validator != null) {
                  _errorMessage = widget.validator;
                  setState(() {});
                }

                if (value!.isEmpty) {
                  _errorMessage = "Champs obligatoire";
                  setState(() {});
                }

                if (value.trim().isEmpty) {
                  _errorMessage = "Champs obligatoire";
                  setState(() {});
                }

                return widget.isRequired ? _errorMessage : null;
              },
              onChanged: (value) {
                _errorMessage = null;
                setState(() {});
                resetTimer();
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              onEditingComplete: widget.onEditingComplete,
              onFieldSubmitted: widget.onFieldSubmitted,
              textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
              focusNode: _focusNode,
              inputFormatters: widget.inputFormatters,
              labelText: widget.labelText,
              hintText: widget.hintText,
            ),
          ),
        ),
        Visibility(
          visible: widget.showError,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacers.sw1,
              BodyText(widget.isRequired == false ? "" : _errorMessage ?? "", color: Colors.red, fontSize: 13),
            ],
          ),
        ),
        !widget.showError ? Spacers.sw2 : Container(),
      ],
    );
  }

  void _onChangeValue() {
    _errorMessage = null;
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void startTimer() {
    _checkTypingTimer = Timer(const Duration(milliseconds: 300), () {
      if (widget.onEditingCompleted != null) {
        widget.onEditingCompleted!(widget.controller!.text);
      }
      debugPrint(widget.controller!.text);
    });
  }

  void resetTimer() {
    _checkTypingTimer?.cancel();
    startTimer();
  }
}
