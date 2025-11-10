import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class Modals {
  static void showBottomModal(BuildContext context, {required Widget child, bool isScrollable = false, bool isDismissible = true, double? height, EdgeInsets? padding}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: isScrollable,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.white,
      useSafeArea: true,
      elevation: SizerHelper.w(1),
      showDragHandle: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(padding: padding ?? EdgeInsets.all(SizerHelper.w(6)), child: child),
        );
      },
    );
  }
}
