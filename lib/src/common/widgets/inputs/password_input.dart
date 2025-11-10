import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets.dart';

class PasswordInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String? text;
  final String? hintText;
  final bool? nextInputForm;
  final Color? textColor;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool showIsRequired;

  const PasswordInput(this.controller, {super.key, this.text, this.hintText, this.nextInputForm, this.textColor, this.focusNode, this.onChanged, this.showIsRequired = true});

  @override
  ConsumerState<PasswordInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<PasswordInput> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return BasicTextForm(
          controller: widget.controller,
          nextInputForm: widget.nextInputForm,
          textAlign: TextAlign.start,
          hintText: widget.hintText,
          text: widget.text,
          showIsRequired: widget.showIsRequired,
          obscureText: obscureText,
          maxLines: 1,
          textCapitalization: TextCapitalization.none,
          suffix: GestureDetector(
            onTap: () => setState(() {
              obscureText = !obscureText;
            }),
            child: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: Colors.black),
          ),
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          focusNode: widget.focusNode,
        );
      },
    );
  }
}
