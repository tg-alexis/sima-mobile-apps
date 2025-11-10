import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../styles/styles.dart';
import '../../../utils/utils.dart';

class CircularLoading extends StatefulWidget {
  const CircularLoading({super.key});

  @override
  CircularLoadingState createState() => CircularLoadingState();
}

class CircularLoadingState extends State<CircularLoading> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
      child: SpinKitFadingCircle(
        color: AppColors.primaryColor,
        size: SizerHelper.w(12),
      ),
    );
  }
}
