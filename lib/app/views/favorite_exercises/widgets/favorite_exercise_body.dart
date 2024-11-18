import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/views/favorite_exercises/controller/favorite_exercises_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';
import 'package:muscle_zone/core/widgets/card/custom_grid.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A widget that displays the favorite exercises.
class FavoriteExercisesBody extends GetView<FavoriteExercisesController> {
  /// Constructs a [FavoriteExercisesBody] widget.
  const FavoriteExercisesBody({super.key});

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

      return CustomGridView<BaseObjectModel>(
        items: controller.exercises,
        childAspectRatio: 0.62,
        itemBuilder: (context, exercise) => Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Image.network(
                          exercise.gifUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              controller.removeExercise(exercise.id),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name.toTitleCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    _buildInfoRow(
                      Icons.fitness_center,
                      exercise.translatedBodyPart,
                    ),
                    _buildInfoRow(
                      Icons.sports_gymnastics,
                      exercise.translatedEquipment,
                    ),
                    _buildInfoRow(
                      Icons.track_changes,
                      exercise.translatedTarget,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Expanded(
            child: CustomText.bodySmall(text, textAlign: TextAlign.start),
          ),
        ],
      ),
    );
  }
}
