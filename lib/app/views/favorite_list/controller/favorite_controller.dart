import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/services/local/hive_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_dialog.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_input_dialog.dart';

/// Controller class for managing favorite exercise lists.
class FavoriteController extends GetxController {
  /// Constructs a [FavoriteController].
  FavoriteController(this._hiveService);

  /// The HiveService instance.
  final HiveService _hiveService;

  /// The list of favorite lists.
  final favoriteLists = <FavoriteList>[].obs;

  /// Whether a new list is being added.
  final isAddingNewList = false.obs;

  /// The controller for the new list name.
  final newListController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadFavoriteLists();
  }

  /// Loads the favorite lists from the Hive database.
  void loadFavoriteLists() {
    favoriteLists.value = _hiveService.getFavoritesBox().values.toList();
  }

  /// Checks if an exercise is in any favorite list.
  bool isExerciseFavorite(String exerciseId) {
    return _hiveService.isExerciseInAnyList(exerciseId);
  }

  /// Starts the process of adding a new favorite list.
  void startAddingNewList() {
    isAddingNewList.value = true;
  }

  /// Saves a new favorite list.
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

  /// Adds an exercise to a favorite list.
  Future<void> addExerciseToList(String listName, String exerciseId) async {
    await _hiveService.addExerciseToList(listName, exerciseId);
    Get.back<void>();
    update();
  }

  /// Edits the name of a favorite list.
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

  /// Deletes a favorite list.
  Future<void> deleteList(FavoriteList list) async {
    final confirm = await CustomDialog.show(
      title: AppKeys.deleteList,
      content: AppKeys.sureDelete,
      confirmText: AppKeys.delete,
      confirmColor: Colors.red,
    );

    if (confirm ?? false) {
      await _hiveService.deleteList(list);
      loadFavoriteLists();
    }
  }

  /// Removes an exercise from all favorite lists.
  Future<void> removeExerciseFromAllLists(String exerciseId) async {
    for (final list in favoriteLists) {
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
