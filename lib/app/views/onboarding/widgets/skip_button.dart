import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A button that allows users to skip the onboarding process.
class SkipButton extends StatelessWidget {
  /// Constructs a [SkipButton] widget.
  const SkipButton({
    required this.onPressed,
    this.isVisible = true,
    super.key,
  });

  /// Callback function to handle button press.
  final VoidCallback onPressed;

  /// Whether the button is visible.
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: TextButton(
        onPressed: isVisible ? onPressed : null,
        child: CustomText.labelLarge(
          AppKeys.skip,
          color: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
