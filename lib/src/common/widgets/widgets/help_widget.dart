import 'package:flutter/material.dart';

import '../../../styles/styles.dart';
import '../../../utils/utils.dart';

class HelpIconWidget extends StatefulWidget {
  final Function()? onTap;
  final Color? color;
  final Color? iconColor;
  final Color? borderColor;
  const HelpIconWidget({super.key, this.onTap, this.color, this.iconColor, this.borderColor});

  @override
  HelpIconWidgetState createState() => HelpIconWidgetState();
}

class HelpIconWidgetState extends State<HelpIconWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(SizerHelper.w(2)),
        decoration: BoxDecoration(
          color: widget.color ?? Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.help_outline,
          size: SizerHelper.w(6),
          color: widget.iconColor ?? AppColors.primaryColor,
        ),
      ),
    );
  }
}
