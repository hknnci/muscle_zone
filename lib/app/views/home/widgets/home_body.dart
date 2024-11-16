import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/routes.dart';
import 'package:muscle_zone/app/views/home/widgets/home_view_grid.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

class HomeBody extends StatelessWidget {
  final HomeController controller;

  const HomeBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomText.titleLarge(AppKeys.selectBodyPart),
        ),
        Obx(() {
          if (controller.bodyParts.isEmpty) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Expanded(
            child: HomeViewGrid(
              bodyParts: controller.bodyParts,
              onBodyPartSelected: (bodyPart) {
                Get.toNamed(Routes.exercises, arguments: bodyPart);
              },
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed(Routes.favoriteLists),
              icon: const Icon(Icons.favorite),
              label: const Text(AppKeys.favoriteLists),
            ),
          ),
        ),
      ],
    );
  }
}
