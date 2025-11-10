import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/assets.gen.dart';
import '../../../utils/navigation/navigation.dart';
import '../../features.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late AuthController _authController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );
    _authController = ref.read(authControllerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPreferences();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Assets.images.logoSima.image(width: 50.w)),
    );
  }

  void initPreferences() async {
    Future.delayed(Duration(seconds: 2));
    await _authController.checkUserLoggedIn();

    if (!mounted) return;

    if (_authController.user != null) {
      NavigationUtil.pushReplacement(context, HomeScreen());
      return;
    }

    NavigationUtil.pushReplacement(context, LoginScreen());
  }
}
