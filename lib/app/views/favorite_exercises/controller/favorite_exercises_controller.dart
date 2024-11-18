import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/app/services/local/hive_service.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_dialog.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

/// Controller class for managing favorite exercises.
class FavoriteExercisesController extends GetxController {
  /// Creates a new instance of [FavoriteExercisesController]
  /// with the given services.
  FavoriteExercisesController(this._hiveService, this._exerciseService);

  final HiveService _hiveService;
  final ExerciseService _exerciseService;

  /// List of exercises that are marked as favorite
  final exercises = <BaseObjectModel>[].obs;

  /// Loading state indicator for the view
  final isLoading = true.obs;

  /// Currently selected favorite list
  late FavoriteList currentList;

  @override
  void onInit() {
    super.onInit();
    currentList = Get.arguments as FavoriteList;
    loadExercises();
  }

  /// Loads exercises from the current favorite list
  /// and updates the [exercises] list.
  Future<void> loadExercises() async {
    isLoading.value = true;
    try {
      final exercisesList = await Future.wait(
        currentList.exerciseIds.map(_exerciseService.getExerciseById),
      );
      exercises.value = exercisesList.whereType<BaseObjectModel>().toList();
    } catch (e) {
      CustomFlushbar.showError(AppKeys.failedToLoadExercises);
    } finally {
      isLoading.value = false;
    }
  }

  /// Removes the exercise with the given [exerciseId]
  /// from the current favorite list
  /// after showing a confirmation dialog.
  Future<void> removeExercise(String exerciseId) async {
    final confirm = await CustomDialog.show(
      title: AppKeys.removeExercise,
      content: AppKeys.removeExerciseConfirm,
      confirmColor: Colors.red,
    );

    if (confirm ?? false) {
      await _hiveService.removeExerciseFromList(currentList, exerciseId);
      await loadExercises();
      Get.find<FavoriteListController>().loadFavoriteLists();
      CustomFlushbar.showSuccess(AppKeys.exerciseRemoved);
    }
  }
}
