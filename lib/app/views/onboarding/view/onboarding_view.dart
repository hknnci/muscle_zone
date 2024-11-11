import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/onboarding/controller/onboarding_controller.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/buttons/gradient_elevated_button.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

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
                          child: controller.buildPage(controller.pages[index]),
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
                          (index) => controller.buildIndicator(index),
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
                        text: controller.isLastPage ? "Get Started" : "Next",
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
                  () => AnimatedOpacity(
                    opacity: controller.isLastPage ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: TextButton(
                      onPressed: controller.navigateToHome,
                      child: CustomText.labelLarge(
                        "Skip",
                        color: Get.theme.primaryColor,
                      ),
                    ),
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
