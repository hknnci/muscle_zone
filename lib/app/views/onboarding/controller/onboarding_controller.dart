import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muscle_zone/app/models/onboarding_page_model.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/constants/routes.dart';

class OnboardingController extends GetxController {
  final SharedPrefService _sharedPref;
  final PageController pageController = PageController();
  var currentPageIndex = 0.obs;

  OnboardingController(this._sharedPref);

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

  Future<void> onNextButtonPressed() async {
    if (isLastPage) {
      await navigateToHome();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> navigateToHome() async {
    await _sharedPref.setFirstLaunchCompleted();
    Get.offNamed(Routes.home);
  }
}
