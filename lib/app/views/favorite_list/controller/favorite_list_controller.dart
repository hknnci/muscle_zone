import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/services/local/hive_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_dialog.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_input_dialog.dart';

class FavoriteListController extends GetxController {
  final HiveService _hiveService;

  FavoriteListController(this._hiveService);

  final favoriteLists = <FavoriteList>[].obs;
  final isAddingNewList = false.obs;
  final newListController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadFavoriteLists();
  }

  void loadFavoriteLists() {
    favoriteLists.value = _hiveService.getFavoritesBox().values.toList();
  }

  bool isExerciseFavorite(String exerciseId) {
    return _hiveService.isExerciseInAnyList(exerciseId);
  }

  void startAddingNewList() {
    isAddingNewList.value = true;
  }

  Future<void> saveNewList() async {
    if (newListController.text.isNotEmpty) {
      final newList = FavoriteList(
        name: newListController.text,
        exerciseIds: [],
      );
      await _hiveService.addFavoriteList(newList);
      newListController.clear();
      isAddingNewList.value = false;
      loadFavoriteLists();
    }
  }

  Future<void> addExerciseToList(String listName, String exerciseId) async {
    await _hiveService.addExerciseToList(listName, exerciseId);
    Get.back();
    update();
  }

  Future<void> editListName(FavoriteList list) async {
    final result = await CustomInputDialog.show(
      title: AppKeys.editListName,
      hintText: AppKeys.newListName,
      initialValue: list.name,
    );

    if (result != null && result.isNotEmpty) {
      await _hiveService.updateListName(list, result);
      loadFavoriteLists();
    }
  }

  Future<void> deleteList(FavoriteList list) async {
    final confirm = await CustomDialog.show(
      title: AppKeys.deleteList,
      content: AppKeys.sureDelete,
      confirmText: AppKeys.confirm,
      confirmColor: Colors.red,
    );

    if (confirm == true) {
      await _hiveService.deleteList(list);
      loadFavoriteLists();
    }
  }

  Future<void> removeExerciseFromAllLists(String exerciseId) async {
    for (var list in favoriteLists) {
      if (list.exerciseIds.contains(exerciseId)) {
        list.exerciseIds.remove(exerciseId);
        await list.save();
      }
    }
    loadFavoriteLists();
    update();
  }

  @override
  void onClose() {
    newListController.dispose();
    super.onClose();
  }
}
