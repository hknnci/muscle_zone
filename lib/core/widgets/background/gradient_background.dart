import 'package:flutter/material.dart';

/// A widget that creates a gradient background.
/// Can be customized with specific colors or use preset color schemes
/// for home screen and onboarding screens.
class GradientBackground extends StatelessWidget {
  /// Constructs a [GradientBackground] widget.
  const GradientBackground({
    super.key,
    this.child,
    this.colors,
    this.isHomeScreen = false,
  });

  /// Child widget to be displayed on top of the gradient background.
  final Widget? child;

  /// Custom colors for the gradient. If null, preset colors will be used.
  final List<Color>? colors;

  /// Determines whether to use home screen or onboarding color scheme.
  final bool isHomeScreen;

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
