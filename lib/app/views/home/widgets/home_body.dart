import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';
import 'package:muscle_zone/app/views/home/widgets/home_view_grid.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/routes.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// Home page body component.
class HomeBody extends StatelessWidget {
  /// Constructs a [HomeBody] widget.
  const HomeBody({required this.controller, super.key});

  /// Takes a [controller] parameter for home page control.
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomText.titleLarge(AppKeys.selectBodyPart),
        ),
        Obx(() {
          if (controller.bodyParts.isEmpty) {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Expanded(
            child: HomeViewGrid(
              bodyParts: controller.bodyParts,
              onBodyPartSelected: (bodyPart) {
                Get.toNamed<dynamic>(Routes.exercises, arguments: bodyPart);
              },
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed<dynamic>(Routes.favoriteLists),
              icon: const Icon(Icons.favorite),
              label: const Text(AppKeys.favoriteLists),
            ),
          ),
        ),
      ],
    );
  }
}
