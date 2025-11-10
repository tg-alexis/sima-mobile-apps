import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../widgets.dart';

class HeaderWidget extends StatelessWidget {
  final String? title;

  const HeaderWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackIconWidget(),
        MediumText(title ?? ""),
        // GestureDetector(onTap: () => AppExtension.showHelpDialogs(context), behavior: HitTestBehavior.translucent, child: const HelpIconWidget()),
      ],
    );
  }
}
