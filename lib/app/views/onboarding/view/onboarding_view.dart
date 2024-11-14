import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/onboarding/controller/onboarding_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/progress/page_indicator.dart';
import 'package:muscle_zone/core/widgets/buttons/gradient_elevated_button.dart';
import 'package:muscle_zone/core/widgets/buttons/skip_button.dart';
import 'package:muscle_zone/core/widgets/page/onboarding_page.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: OnboardingPage(page: controller.pages[index]),
                        );
                      },
                    ),
                  ),

                  // Page Indicator
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
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
                      () => GradientElevatedButton(
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
