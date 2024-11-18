import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/utils/translation_helper.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A bottom sheet widget that filters exercises by equipment and target.
class FilterBottomSheet extends StatelessWidget {
  /// Constructs a [FilterBottomSheet] widget.
  const FilterBottomSheet({
    required this.controller,
    super.key,
  });

  /// The controller for the exercises.
  final ExercisesController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.equipmentList.isEmpty || controller.targetList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText.titleLarge(AppKeys.filterExercises),
            const SizedBox(height: 16),

            // Equipment Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppKeys.equipment,
                border: const OutlineInputBorder(),
              ),
              value: controller.selectedEquipment.value.isEmpty
                  ? AppKeys.all
                  : controller.selectedEquipment.value,
              items: controller.equipmentList.map((equipment) {
                final text = equipment.toLowerCase() == 'all'
                    ? AppKeys.all
                    : TranslationHelper.translateEquipment(equipment);
                return DropdownMenuItem(
                  value: equipment,
                  child: Text(text),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectedEquipment.value = value;
              },
            ),

            const SizedBox(height: 16),

            // Target Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppKeys.target,
                border: const OutlineInputBorder(),
              ),
              value: controller.selectedTarget.value.isEmpty
                  ? AppKeys.all
                  : controller.selectedTarget.value,
              items: controller.targetList.map((target) {
                final text = target.toLowerCase() == 'all'
                    ? AppKeys.all
                    : TranslationHelper.translateTarget(target);
                return DropdownMenuItem(
                  value: target,
                  child: Text(text),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.selectedTarget.value = value;
              },
            ),

            const SizedBox(height: 24),

            // Filter Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.applyFilters();
                  Get.back<void>();
                },
                child: Text(AppKeys.apply),
              ),
            ),
          ],
        ),
      );
    });
  }
}
