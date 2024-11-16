import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/app/services/local/hive_service.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_dialog.dart';

class FavoriteExercisesController extends GetxController {
  final HiveService _hiveService;
  final ExerciseService _exerciseService;

  FavoriteExercisesController(this._hiveService, this._exerciseService);

  final exercises = <BaseObjectModel>[].obs;
  final isLoading = true.obs;
  late FavoriteList currentList;

  @override
  void onInit() {
    super.onInit();
    currentList = Get.arguments;
    loadExercises();
  }

  Future<void> loadExercises() async {
    isLoading.value = true;
    try {
      final exercisesList = await Future.wait(currentList.exerciseIds
          .map((id) => _exerciseService.getExerciseById(id)));
      exercises.value = exercisesList.whereType<BaseObjectModel>().toList();
    } catch (e) {
      print('An error occurred while loading exercises: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeExercise(String exerciseId) async {
    final confirm = await CustomDialog.show(
      title: AppKeys.removeExercise,
      content: AppKeys.removeExerciseConfirm,
      confirmText: AppKeys.confirm,
      confirmColor: Colors.red,
    );

    if (confirm == true) {
      await _hiveService.removeExerciseFromList(currentList, exerciseId);
      await loadExercises();
      final favoriteController = Get.find<FavoriteListController>();
      favoriteController.loadFavoriteLists();
    }
  }
}
