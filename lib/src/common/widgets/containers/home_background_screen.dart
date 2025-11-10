import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class HomeBackgroundContainer extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;
  final EdgeInsetsGeometry? padding;

  const HomeBackgroundContainer({super.key, required this.child, this.padding, this.useSafeArea = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.white),
        useSafeArea
            ? SafeArea(
                child: Padding(
                  padding: padding ?? EdgeInsets.symmetric(horizontal: SizerHelper.w(4)),
                  child: child,
                ),
              )
            : Padding(
                padding: padding ?? EdgeInsets.symmetric(horizontal: SizerHelper.w(4)),
                child: child,
              ),
      ],
    );
  }
}
