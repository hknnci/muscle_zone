import 'package:flutter/material.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A custom elevated button for onboarding screens.
class OnboardingElevatedButton extends StatelessWidget {
  /// Constructs an [OnboardingElevatedButton] widget.
  const OnboardingElevatedButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  /// Callback function to handle button press.
  final VoidCallback onPressed;

  /// Text to be displayed on the button.
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.blue, Colors.black],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 150),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: CustomText.labelLarge(text),
          ),
        ),
      ),
    );
  }
}
