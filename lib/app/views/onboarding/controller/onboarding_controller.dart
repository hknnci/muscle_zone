import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/local/onboard/onboarding_page_model.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/constants.dart';
import 'package:muscle_zone/core/constants/routes.dart';

/// Controller class that manages the state.
class OnboardingController extends GetxController {
  /// Constructs a [OnboardingController] widget.
  OnboardingController(this._sharedPref);

  /// Local storage service
  final SharedPrefService _sharedPref;

  /// Controller for handling page transitions
  final PageController pageController = PageController();

  /// Current index of the onboarding page being displayed
  final RxInt currentPageIndex = 0.obs;

  /// List of onboarding pages containing content to be displayed
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

  /// Returns true if the current page is the last page
  /// in the onboarding sequence
  bool get isLastPage => currentPageIndex.value == pages.length - 1;

  /// Returns the current onboarding page model being displayed
  OnboardingPageModel get currentPage => pages[currentPageIndex.value];

  /// Updates the current page index to the specified value
  // ignore: use_setters_to_change_properties
  void updatePageIndex(int index) {
    currentPageIndex.value = index;
  }

  /// Handles the next button press event.
  /// If on the last page, navigates to home screen.
  /// Otherwise, advances to the next onboarding page.
  Future<void> onNextButtonPressed() async {
    if (isLastPage) {
      await navigateToHome();
    } else {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Marks first launch as completed in shared preferences and
  /// navigates to the home screen
  Future<void> navigateToHome() async {
    await _sharedPref.setFirstLaunchCompleted();
    await Get.offNamed<void>(Routes.home);
  }
}
