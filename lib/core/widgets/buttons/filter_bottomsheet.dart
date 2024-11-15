import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';

class EquipmentFilterBottomSheet extends StatelessWidget {
  final ExercisesController controller;

  const EquipmentFilterBottomSheet({Key? key, required this.controller})
      : super(key: key);

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
              Get.back();
            },
          );
        },
      );
    });
  }
}
