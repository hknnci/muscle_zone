import 'package:flutter/material.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A widget that displays text with a gradient color effect.
/// Can be used in both app bar and regular contexts.
class GradientText extends StatelessWidget {
  /// Constructs a [GradientText] widget.
  const GradientText(
    this.text, {
    this.isAppBar = false,
    super.key,
  });

  /// The text to be displayed
  final String text;

  /// Whether the text is used in an app bar
  final bool isAppBar;

  @override
  Widget build(BuildContext context) {
    const Gradient textGradient = LinearGradient(
      colors: [Colors.purple, Colors.blue],
    );
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => textGradient.createShader(bounds),
      child: isAppBar
          ? CustomText.titleLarge(text)
          : CustomText.headlineLarge(text),
    );
  }
}
