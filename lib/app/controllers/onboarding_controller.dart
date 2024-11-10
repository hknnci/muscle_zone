import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muscle_zone/app/models/onboarding_page_model.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPageIndex = 0.obs;

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      imagePath: "assets/images/img_onboarding1.png",
      title: "Welcome to MuscleZone",
      description:
          "Get ready to transform your body with the best exercises with or without equipment, at home or at gym.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/img_onboarding2.png",
      title: "Track Your Progress",
      description:
          "Track your progress and see the improvements you are making over time.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/img_onboarding3.png",
      title: "Start Now",
      description:
          "Let’s get started on your fitness journey today with personalized workouts.",
    ),
  ];

  bool get isLastPage => currentPageIndex.value == pages.length - 1;

  OnboardingPageModel get currentPage => pages[currentPageIndex.value];

  void updatePageIndex(int index) {
    currentPageIndex.value = index;
  }

  void onNextButtonPressed() {
    if (isLastPage) {
      navigateToHome();
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void navigateToHome() {
    Get.offNamed("/home");
  }

  void skipOnboarding() {
    navigateToHome();
  }

  Widget buildPage(OnboardingPageModel page) {
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

  Widget buildIndicator(int index) {
    bool isActive = index == currentPageIndex.value;
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
