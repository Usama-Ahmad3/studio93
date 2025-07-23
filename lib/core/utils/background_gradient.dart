import 'package:flutter/material.dart';
import 'package:studio93/res/app_colors.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  const BackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.center,
          begin: Alignment.topCenter,
          colors: [Color(0xffe1f3e3), Color(0xffe2f1e3), AppColors.whiteColor],
        ),
      ),
      child: child,
    );
  }
}
