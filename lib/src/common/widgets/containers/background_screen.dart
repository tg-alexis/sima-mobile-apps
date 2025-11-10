import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../styles/colors/colors.dart';
import '../../../utils/utils.dart';

class BackgroundScreen extends ConsumerStatefulWidget {
  final Widget child;
  final bool useSafeArea;
  final EdgeInsets? padding;
  final Color? color;
  final ScrollPhysics? physics;

  const BackgroundScreen({
    super.key,
    required this.child,
    this.useSafeArea = false,
    this.padding,
    this.color,
    this.physics,
  });

  @override
  ConsumerState<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends ConsumerState<BackgroundScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.white),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor.withValues(alpha: 0.3),
                AppColors.primaryColor.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
        widget.useSafeArea
            ? SafeArea(child: _buildBackground())
            : _buildBackground(),
      ],
    );
  }

  Widget _buildBackground() {
    return Padding(
      padding:
          widget.padding ?? EdgeInsets.symmetric(horizontal: SizerHelper.w(5)),
      child: widget.child,
    );
  }
}
