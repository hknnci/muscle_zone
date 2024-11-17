import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';
import 'package:muscle_zone/app/views/home/widgets/home_body.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

/// Widget that represents the home page view.
class HomeView extends GetView<HomeController> {
  /// Constructs a [HomeView] widget.
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      isHomeScreen: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: GradientText(AppKeys.muscleZone, isAppBar: true),
        ),
        body: HomeBody(controller: controller),
      ),
    );
  }
}
