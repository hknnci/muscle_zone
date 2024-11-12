import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

//Used in OnboardingView
class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isVisible;

  const SkipButton({
    Key? key,
    required this.onPressed,
    this.isVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: TextButton(
        onPressed: isVisible ? onPressed : null,
        child: CustomText.labelLarge(
          "Skip",
          color: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
