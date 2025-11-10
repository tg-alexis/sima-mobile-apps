import 'package:flutter/material.dart';

import '../../../styles/styles.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class DialogContent extends StatelessWidget {
  final bool isError;
  final Widget? content;
  final IconData? icon;
  final Function defaultCallback;
  final Function? sideCallback;
  final String? defaultButtonText;
  final String? sideButtonText;

  const DialogContent({
    super.key,
    this.content,
    this.icon,
    required this.defaultCallback,
    this.defaultButtonText,
    this.sideCallback,
    this.sideButtonText = "",
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizerHelper.w(1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizerHelper.w(3)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(SizerHelper.w(1.5)),
              decoration: BoxDecoration(
                color: isError
                    ? Colors.redAccent.withValues(alpha: 0.2)
                    : AppColors.primaryColor.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(SizerHelper.w(0.5)),
                decoration: BoxDecoration(
                  color: isError
                      ? Colors.redAccent.withValues(alpha: 0.5)
                      : AppColors.primaryColor.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(SizerHelper.w(2)),
                  child: Icon(
                    icon ?? (isError ? Icons.info_outline : Icons.check),
                    color: Colors.white,
                    size: SizerHelper.w(10),
                  ),
                ),
              ),
            ),
            Spacers.sw6,
            content!,
            Spacers.large,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                contentButton(
                  context,
                  callback: defaultCallback,
                  text: defaultButtonText,
                  backgroundColor: isError
                      ? Colors.red
                      : AppColors.primaryColor,
                ),
                Spacers.sw1,
                Visibility(
                  visible: sideCallback != null,
                  child: contentButton(
                    context,
                    callback: sideCallback ?? () {},
                    text: sideButtonText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _runCallback(BuildContext context, Function callback) {
    NavigationUtil.pop(context);
    callback();
  }

  Widget contentButton(
    BuildContext context, {
    required Function callback,
    required String? text,
    Color? backgroundColor,
  }) {
    return GestureDetector(
      onTap: () => _runCallback(context, callback),
      child: Container(
        width: SizerHelper.w(10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(SizerHelper.w(5))),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: SizerHelper.w(5)),
            child: MediumText(
              text ?? "",
              color: backgroundColor == null ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
