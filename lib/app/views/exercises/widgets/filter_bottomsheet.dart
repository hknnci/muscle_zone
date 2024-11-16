import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';

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
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.equipmentList.length,
        itemBuilder: (context, index) {
          final equipment = controller.equipmentList[index];
          return ListTile(
            title: Text(equipment.toTitleCase()),
            onTap: () {
              controller.filterExercisesByEquipment(equipment);
              Get.back<void>();
            },
          );
        },
      );
    });
  }
}
