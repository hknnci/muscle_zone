import 'package:flutter/material.dart';

/// A page indicator widget.
/// Displays an animated container that visually shows active or inactive state.
class PageIndicator extends StatelessWidget {
  /// Constructs a [PageIndicator] widget.
  const PageIndicator({
    required this.isActive,
    super.key,
  });

  /// Whether the indicator is active
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: isActive ? 20 : 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF8A2BE2) : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
