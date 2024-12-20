import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/onboarding/controller/onboarding_controller.dart';
import 'package:muscle_zone/app/views/onboarding/widgets/onboarding_elevated_button.dart';
import 'package:muscle_zone/app/views/onboarding/widgets/onboarding_page.dart';
import 'package:muscle_zone/app/views/onboarding/widgets/skip_button.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/progress/page_indicator.dart';

/// A view that introduces app features to the user through onboarding screens.
class OnboardingView extends GetView<OnboardingController> {
  /// Constructs a [OnboardingView] widget.
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // PageView Section
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: controller.updatePageIndex,
                      itemCount: controller.pages.length,
                      padEnds: false,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: OnboardingPage(page: controller.pages[index]),
                        );
                      },
                    ),
                  ),

                  // Page Indicator
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.pages.length,
                          (index) => PageIndicator(
                            isActive:
                                index == controller.currentPageIndex.value,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Next Button
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Obx(
                      () => OnboardingElevatedButton(
                        onPressed: controller.onNextButtonPressed,
                        text: controller.isLastPage
                            ? AppKeys.getStarted
                            : AppKeys.next,
                      ),
                    ),
                  ),
                ],
              ),

              // Skip Button
              Positioned(
                top: 10,
                right: 16,
                child: Obx(
                  () => SkipButton(
                    onPressed: controller.navigateToHome,
                    isVisible: !controller.isLastPage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
