import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/routes.dart';
import 'package:muscle_zone/core/widgets/card/custom_card.dart';
import 'package:muscle_zone/core/widgets/card/custom_grid.dart';
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
          child: CustomText.titleMedium(AppKeys.selectBodyPart),
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
            child: CustomGridView<String>(
              childAspectRatio: 0.75,
              crossAxisCount: 3,
              items: controller.bodyParts,
              itemBuilder: (context, bodyPart) => CustomCard(
                bodyPart: bodyPart,
                onTap: () => Get.toNamed<dynamic>(
                  Routes.exercises,
                  arguments: bodyPart,
                ),
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8E2DE2).withAlpha(76),
                    blurRadius: 25,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => Get.toNamed<dynamic>(Routes.favoriteLists),
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xFF8E2DE2),
                        Color(0xFF4A00E0),
                        Color(0xFF6441A5),
                      ],
                    ).createShader(bounds);
                  },
                  child: const Icon(
                    Icons.favorite,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
