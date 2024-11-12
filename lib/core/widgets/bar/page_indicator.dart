import 'package:flutter/material.dart';

//Used in OnboardingView
class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({Key? key, required this.isActive}) : super(key: key);

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
