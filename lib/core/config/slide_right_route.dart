import 'package:flutter/material.dart';

class SlideRightRoute<T> extends PageRouteBuilder<T> {
  SlideRightRoute({required Widget page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 500), // custom duration
    reverseTransitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
