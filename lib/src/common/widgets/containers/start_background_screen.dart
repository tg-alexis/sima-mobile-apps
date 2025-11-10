import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../styles/colors/colors.dart';
import '../../../utils/utils.dart';

class StartBackgroundScreen extends ConsumerStatefulWidget {
  final Widget child;
  final bool useSafeArea;
  final EdgeInsets? padding;
  final Color? color;

  const StartBackgroundScreen({super.key, required this.child, this.useSafeArea = false, this.padding, this.color});

  @override
  ConsumerState<StartBackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends ConsumerState<StartBackgroundScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0XFFA157A6), AppColors.purpleColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Positioned(
          bottom: SizerHelper.w(150),
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            height: SizerHelper.w(50),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0XFFA157A6), AppColors.purpleColor], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(SizerHelper.w(6)), bottomRight: Radius.circular(SizerHelper.w(6))),
            ),
          ),
        ),
        widget.useSafeArea
            ? SafeArea(
                child: Padding(
                  padding: widget.padding ?? EdgeInsets.symmetric(horizontal: SizerHelper.w(5)),
                  child: widget.child,
                ),
              )
            : Padding(
                padding: widget.padding ?? EdgeInsets.symmetric(horizontal: SizerHelper.w(5)),
                child: widget.child,
              ),
      ],
    );
  }
}
