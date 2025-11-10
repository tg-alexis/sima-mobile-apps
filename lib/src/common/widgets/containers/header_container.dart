import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../common.dart';

class HeaderContainer extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? backWidget;
  final Widget? actionWidget;
  final bool showBack;
  final bool showAction;
  final Function()? onBack;
  final Function()? actionCallback;

  const HeaderContainer({
    super.key,
    required this.title,
    this.subTitle,
    this.backWidget,
    this.onBack,
    this.showBack = true,
    this.showAction = false,
    this.actionWidget,
    this.actionCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(SizerHelper.w(6)),
          bottomRight: Radius.circular(SizerHelper.w(6)),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: SizerHelper.w(4)),
      child: Stack(
        children: [
          Visibility(
            visible: showBack,
            child: backWidget ?? BackIconWidget(onTap: onBack),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MediumText(title, textAlign: TextAlign.center),
                Visibility(
                  visible: subTitle != null,
                  child: Column(
                    children: [
                      Spacers.sw1,
                      BodyText(subTitle ?? "", textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: showAction,
            child: Positioned(
              right: 0,
              child:
                  actionWidget ??
                  GestureDetector(onTap: actionCallback, child: Container()),
            ),
          ),
        ],
      ),
    );
  }
}
