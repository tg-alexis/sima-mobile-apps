import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/common.dart';
import '../../../utils/utils.dart';
import '../../features.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Assets.images.logoSima.image(width: 50.w)),
    );
  }

  void initPreferences() async {
    // Attendre 2 secondes pour afficher le logo
    await Future.delayed(Duration(seconds: 2));

    if (!mounted) return;

    // Demander les permissions nécessaires
    await _requestPermissions();

    if (!mounted) return;

    // Vérifier si l'utilisateur est déjà connecté
    final authController = ref.read(authControllerProvider);
    await authController.checkUserLoggedIn();

    if (!mounted) return;

    if (authController.user != null) {
      NavigationUtil.pushReplacement(context, HomeScreen());
      return;
    }

    NavigationUtil.pushReplacement(context, LoginScreen());
  }

  Future<void> _requestPermissions() async {
    // Demander la permission de la caméra
    final cameraStatus = await requestPermission(Permission.camera);

    if (!cameraStatus) {
      // Si la permission est refusée, afficher un dialog informatif
      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.camera_alt, color: Colors.orange),
                SizedBox(width: SizerHelper.w(2)),
                Expanded(
                  child: BodyText(
                    "Permission caméra",
                    fontSize: SizerHelper.sp(18),
                  ),
                ),
              ],
            ),
            content: BodyText(
              "L'accès à la caméra est nécessaire pour scanner les QR codes. Vous pouvez activer cette permission plus tard dans les paramètres de votre appareil.",
              fontSize: SizerHelper.sp(14),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  // Ouvrir les paramètres de l'application
                  await openAppSettings();
                },
                child: BodyText(
                  "Paramètres",
                  color: Colors.blue,
                  fontSize: SizerHelper.sp(14),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: BodyText(
                  "Plus tard",
                  color: Colors.grey,
                  fontSize: SizerHelper.sp(14),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
