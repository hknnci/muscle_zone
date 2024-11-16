import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_exercises/controller/favorite_exercises_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';

class FavoriteExercisesBody extends GetView<FavoriteExercisesController> {
  const FavoriteExercisesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.exercises.isEmpty) {
        return Center(
          child: CustomText.titleLarge(AppKeys.noExerciseInList),
        );
      }

      return ListView.builder(
        itemCount: controller.exercises.length,
        itemBuilder: (context, index) {
          final exercise = controller.exercises[index];
          return ListTile(
            title: Text(exercise.name.toTitleCase()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => controller.removeExercise(exercise.id),
            ),
            onTap: () {
              // Get.toNamed(Routes.exerciseDetail, arguments: exercise);
            },
          );
        },
      );
    });
  }
}
