import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../styles/styles.dart';
import '../widgets.dart';

class SearchInput extends ConsumerStatefulWidget {
  final String? text;
  final String? hintText;
  final bool? nextInputForm;
  final Color? textColor;
  final FocusNode? focusNode;
  final Function(String)? onChanged;

  const SearchInput({super.key, this.text, this.hintText, this.nextInputForm, this.textColor, this.focusNode, this.onChanged});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  Timer? _checkTypingTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return BasicTextForm(
        controller: _controller,
        nextInputForm: widget.nextInputForm,
        textAlign: TextAlign.start,
        hintText: widget.hintText,
        textAlignVertical: TextAlignVertical.center,
        showError: false,
        prefix: const Icon(
          Icons.search,
          color: Color(0xFFADAEBC),
        ),
        onChanged: (value) {
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        focusNode: widget.focusNode,
      );
    });
  }
}
