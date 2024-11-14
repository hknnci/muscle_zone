import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  final List<Color>? colors;
  final bool isHomeScreen;

  const GradientBackground({
    Key? key,
    this.child,
    this.colors,
    this.isHomeScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingColors = [
      const Color(0xFFE3F2FD),
      const Color(0xFFFCE4EC),
      const Color(0xFFFFF3E0),
    ];

    final homeScreenColors = [
      const Color(0xFFC3AED6),
      const Color(0xFFFFD3B6),
      const Color(0xFFA1C4FD),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              colors ?? (isHomeScreen ? homeScreenColors : onboardingColors),
          stops: const [0.2, 0.5, 0.8],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}
