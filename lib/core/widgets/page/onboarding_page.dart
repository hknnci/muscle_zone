import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/onboarding_page_model.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;

  const OnboardingPage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          page.imagePath,
          height: Get.height * 0.5,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        GradientText(page.title),
        const SizedBox(height: 10),
        CustomText.bodyLarge(
          page.description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
