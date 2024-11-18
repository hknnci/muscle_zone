import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/utils/translation_helper.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A bottom sheet widget that filters exercises by equipment.
class EquipmentFilterBottomSheet extends StatelessWidget {
  /// Constructs an [EquipmentFilterBottomSheet] widget.
  const EquipmentFilterBottomSheet({
    required this.controller,
    super.key,
  });

  /// The controller that manages the exercise data and state
  final ExercisesController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.equipmentList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomText.titleLarge(AppKeys.chooseEquipment),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.equipmentList.length,
              itemBuilder: (context, index) {
                final equipment = controller.equipmentList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue.withAlpha(77),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      equipment.toLowerCase() == 'all'
                          ? AppKeys.all
                          : TranslationHelper.translateEquipment(equipment),
                    ),
                    onTap: () {
                      controller.filterExercisesByEquipment(equipment);
                      Get.back<void>();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
