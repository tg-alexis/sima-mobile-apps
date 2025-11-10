import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sima/src/datasource/datasource.dart';
import 'package:sima/src/features/features.dart';
import 'package:sizer/sizer.dart';

import 'src/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiClientInstance.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Sima 2025',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor,
            ),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
