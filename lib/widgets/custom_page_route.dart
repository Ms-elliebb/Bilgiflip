import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: Curves.easeInOut),
            );
            return FadeTransition(
              opacity: animation.drive(tween),
              child: ScaleTransition(
                scale: animation.drive(tween),
                child: child,
              ),
            );
          },
        );
}
