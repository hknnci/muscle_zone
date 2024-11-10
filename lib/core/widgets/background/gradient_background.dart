import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  final List<Color>? colors;

  const GradientBackground({
    Key? key,
    this.child,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ??
              const [
                Color(0xFFE3F2FD),
                Color(0xFFFCE4EC),
                Color(0xFFFFF3E0),
              ],
          stops: const [0.2, 0.5, 0.8],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}
