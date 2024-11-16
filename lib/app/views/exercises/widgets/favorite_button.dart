import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/app/views/exercises/widgets/favorite_list_bottomsheet.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

class FavoriteButton extends StatelessWidget {
  final ExercisesController controller;

  const FavoriteButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredExercises.isEmpty) {
        return IconButton(
          icon: const Icon(Icons.favorite),
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
                _showFavoriteListsBottomSheet(context, currentExercise);
              }
            },
          );
        },
      );
    });
  }

  void _showFavoriteListsBottomSheet(
      BuildContext context, BaseObjectModel exercise) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FavoriteListsBottomSheet(
        exerciseId: exercise.id,
      ),
    );
  }
}
