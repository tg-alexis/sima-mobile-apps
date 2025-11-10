import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class BackgroundSessionObserver extends StatefulWidget {
  final Widget child;

  const BackgroundSessionObserver({
    super.key,
    required this.child,
  });

  @override
  BackgroundSessionObserverState createState() => BackgroundSessionObserverState();
}

class BackgroundSessionObserverState extends State<BackgroundSessionObserver> with WidgetsBindingObserver {
  bool isLoginScreenShown = false;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    // _secureScreen();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // _unsecureScreen();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("state => $state");
    if (state == AppLifecycleState.paused && !isLoginScreenShown) {
      // goToLogin();
    }
    super.didChangeAppLifecycleState(state);
  }

  // void goToLogin() {
  //   isLoginScreenShown = true;
  //   setState(() {});
  //
  //   NavigationUtil.push(context, const LoginPinScreen(isForAuth: false)).then((value) {
  //     setState(() {
  //       isLoginScreenShown = false;
  //     });
  //   });
  // }
  //
  // void _secureScreen() async {
  //   await ScreenProtector.protectDataLeakageOn();
  //   await ScreenProtector.protectDataLeakageWithBlur();
  // }
  //
  // void _unsecureScreen() async {
  //   await ScreenProtector.protectDataLeakageOff();
  //   await ScreenProtector.protectDataLeakageWithBlurOff();
  // }
}
