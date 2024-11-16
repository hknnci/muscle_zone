import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/splash/controller/splash_controller.dart';
import 'package:muscle_zone/core/constants/constants.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/app/views/splash/widgets/progress_bar.dart';
import 'package:muscle_zone/core/widgets/image/image_widget.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                imagePath: Constants.path_logoMuscleZone,
                width: Get.width * 0.8,
                height: Get.height * 0.1,
              ),
              const SizedBox(height: 48),
              ProgressBar(),
            ],
          ),
        ),
      ),
    );
  }
}
