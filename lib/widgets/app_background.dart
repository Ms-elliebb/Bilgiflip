import 'package:bilgi_flip/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.kBackgroundStart,
            AppColors.kBackgroundEnd,
          ],
          stops: [0.0, 0.7], // Gradyanın geçişini daha yumuşak hale getirir
        ),
      ),
      child: child,
    );
  }
}
