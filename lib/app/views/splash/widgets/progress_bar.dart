import 'package:flutter/material.dart';

/// A progress bar widget used in the splash view.
class ProgressBar extends StatelessWidget {
  /// Constructs a [ProgressBar] instance.
  const ProgressBar({
    this.begin = 0,
    this.end = 2,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.easeInOut,
    super.key,
  });

  /// The beginning value of the progress bar.
  final double begin;

  /// The ending value of the progress bar.
  final double end;

  /// The duration of the progress bar animation.
  final Duration duration;

  /// The curve of the progress bar animation.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
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
