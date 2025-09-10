import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FlashcardView extends StatelessWidget {
  final Widget child;
  final bool isKnown;

  const FlashcardView({
    super.key,
    required this.child,
    this.isKnown = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          colors: isKnown
              ? [AppColors.kSuccessColor.withOpacity(0.8), Colors.greenAccent.withOpacity(0.8)]
              : [AppColors.kPrimaryAccent, AppColors.kSecondaryAccent], // YENİ GRADYAN
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.kCardBackground.withOpacity(0.9),
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
