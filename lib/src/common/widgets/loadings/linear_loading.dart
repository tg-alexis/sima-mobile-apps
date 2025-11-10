import 'package:flutter/material.dart';

import '../../../styles/styles.dart';

class LinearLoading extends StatefulWidget {
  const LinearLoading({super.key});

  @override
  _LinearLoadingState createState() => _LinearLoadingState();
}

class _LinearLoadingState extends State<LinearLoading> {
  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.fromLTRB(100, 8, 100, 8),
      child: LinearProgressIndicator(
        color: AppColors.primaryColor,
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
