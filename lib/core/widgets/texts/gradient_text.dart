import 'package:flutter/material.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const GradientText(
    this.text, {
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Gradient textGradient = const LinearGradient(
      colors: [Colors.purple, Colors.blue],
    );
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => textGradient.createShader(bounds),
      child: CustomText.headlineLarge(text),
    );
  }
}
