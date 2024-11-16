import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muscle_zone/app/models/local/onboard/onboarding_page_model.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/constants/routes.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/constants.dart';

class OnboardingController extends GetxController {
  final SharedPrefService _sharedPref;
  final PageController pageController = PageController();
  var currentPageIndex = 0.obs;

  OnboardingController(this._sharedPref);

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      imagePath: Constants.path_onboardingImg1,
      title: AppKeys.onboardingTitle1,
      description: AppKeys.onboardingDesc1,
    ),
    OnboardingPageModel(
      imagePath: Constants.path_onboardingImg1,
      title: AppKeys.onboardingTitle2,
      description: AppKeys.onboardingDesc2,
    ),
    OnboardingPageModel(
      imagePath: Constants.path_onboardingImg1,
      title: AppKeys.onboardingTitle3,
      description: AppKeys.onboardingDesc3,
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
