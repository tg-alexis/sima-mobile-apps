import 'package:flutter/material.dart';

class InkWellCustom extends StatelessWidget {
  final Function onTap;
  final Function? onTapDown;
  final Function? onTapCancel;
  final Widget child;

  const InkWellCustom({super.key,
    required this.onTap,
    this.onTapDown,
    this.onTapCancel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      radius: 0,
      onTap: () => onTap(),
      onTapDown: (details) => onTapDown != null ? onTapDown!() : null,
      onTapCancel: () => onTapCancel != null ? onTapCancel!() : null,
      child: child,
    );
  }
}
