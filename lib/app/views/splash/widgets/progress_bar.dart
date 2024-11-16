import 'package:flutter/material.dart';

//Used in SplashView
class ProgressBar extends StatelessWidget {
  final double begin;
  final double end;
  final Duration duration;
  final Curve curve;

  const ProgressBar({
    Key? key,
    this.begin = 0,
    this.end = 2,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: begin, end: end),
        duration: duration,
        curve: curve,
        builder: (context, value, child) {
          return LinearProgressIndicator(
            minHeight: 8,
            borderRadius: BorderRadius.circular(12),
            backgroundColor: Colors.grey.shade400,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8A2BE2)),
          );
        },
      ),
    );
  }
}
