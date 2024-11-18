import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/app/views/exercises/widgets/favorite_list_dialog.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

/// A button widget that handles favoriting exercises.
/// Displays different states based on whether the
/// current exercise is favorited or not.
class FavoriteButton extends StatelessWidget {
  /// Constructs a [FavoriteButton] widget.
  const FavoriteButton({
    required this.controller,
    super.key,
  });

  /// The controller that manages the exercise data and state
  final ExercisesController controller;

  void _showFavoriteListDialog(
    BuildContext context,
    BaseObjectModel exercise,
  ) {
    Get.dialog<void>(
      FavoriteListDialog(exerciseId: exercise.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredExercises.isEmpty) {
        return const IconButton(
          icon: Icon(Icons.favorite),
          onPressed: null,
        );
      }

      final currentExercise =
          controller.filteredExercises[controller.currentPageIndex.value];

      return GetBuilder<FavoriteListController>(
        builder: (favoriteController) {
          final isFavorite =
              favoriteController.isExerciseFavorite(currentExercise.id);

          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              if (isFavorite) {
                favoriteController
                    .removeExerciseFromAllLists(currentExercise.id);
                CustomFlushbar.showInfo(AppKeys.exerciseRemoved);
              } else {
                _showFavoriteListDialog(context, currentExercise);
              }
            },
          );
        },
      );
    });
  }
}
