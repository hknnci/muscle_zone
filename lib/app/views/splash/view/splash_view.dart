import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/splash/controller/splash_controller.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/bar/progress_bar_widget.dart';
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
                imagePath: 'assets/images/logo_musclezone.png',
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
