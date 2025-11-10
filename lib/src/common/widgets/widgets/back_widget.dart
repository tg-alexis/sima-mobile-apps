import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../styles/styles.dart';
import '../../../utils/utils.dart';

class BackIconWidget extends StatefulWidget {
  final Function()? onTap;
  final Color? color;
  final Color? iconColor;
  final Color? borderColor;
  final IconData? icon;
  final Widget? iconWidget;

  const BackIconWidget({super.key, this.onTap, this.color, this.iconColor, this.borderColor, this.icon, this.iconWidget});

  @override
  BackIconWidgetState createState() => BackIconWidgetState();
}

class BackIconWidgetState extends State<BackIconWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap ?? () => NavigationUtil.pop(context),
      child: Container(
        padding: EdgeInsets.all(SizerHelper.w(2)),
        decoration: BoxDecoration(color: widget.color ?? AppColors.primaryColor, shape: BoxShape.circle),
        child: widget.icon != null ? Icon(widget.icon, size: SizerHelper.w(6), color: widget.iconColor ?? AppColors.orangeColor) : widget.iconWidget,
      ),
    );
  }
}
