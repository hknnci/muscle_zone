import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/services/local/hive_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_dialog.dart';
import 'package:muscle_zone/core/widgets/dialog/custom_input_dialog.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

/// Controller for managing favorite lists.
class FavoriteListController extends GetxController {
  /// Constructs a [FavoriteListController] widget.
  FavoriteListController(this._hiveService, {required this.exerciseId});

  /// The HiveService instance for interacting with the local database.
  final HiveService _hiveService;

  /// The ID of the exercise to be added to the favorite list.
  late String exerciseId;

  /// The list of favorite lists.
  final favoriteLists = <FavoriteList>[].obs;

  /// Indicates whether a new list is currently being added.
  final isAddingNewList = false.obs;

  /// Text controller for the new list name input.
  final newListController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadFavoriteLists();
  }

  /// Loads and updates the list of favorites from local storage.
  void loadFavoriteLists() {
    favoriteLists.value = _hiveService.getFavoritesBox().values.toList();
  }

  /// Checks if the given exercise is marked as favorite in any list.
  /// Returns true if the [exerciseId] exists in any favorite list.
  bool isExerciseFavorite(String exerciseId) {
    return _hiveService.isExerciseInAnyList(exerciseId);
  }

  /// Sets the [isAddingNewList] flag to true to indicate
  /// that a new list is being added.
  void startAddingNewList() {
    isAddingNewList.value = true;
  }

  /// Creates and saves a new favorite list.
  /// Saves the new list to local storage if the list name is not empty.
  Future<void> saveNewList({bool isFromListScreen = false}) async {
    if (newListController.text.isNotEmpty) {
      final newList = FavoriteList(
        name: newListController.text,
        exerciseIds: isFromListScreen ? [] : [exerciseId],
      );
      await _hiveService.addFavoriteList(newList);
      newListController.clear();
      isAddingNewList.value = false;
      loadFavoriteLists();

      if (!isFromListScreen) {
        Get.back<void>();
      }

      CustomFlushbar.showSuccess(
        isFromListScreen
            ? '${AppKeys.listCreated}: ${newList.name}'
            : '${AppKeys.exerciseAddedToList}: ${newList.name}',
      );

      update();
    }
  }

  /// Adds an exercise to the specified favorite list.
  /// [listName] the name of the list to add the exercise to.
  /// [exerciseId] the unique identifier of the exercise to add.
  Future<void> addExerciseToList(String listName, String exerciseId) async {
    await _hiveService.addExerciseToList(listName, exerciseId);
    loadFavoriteLists();
    CustomFlushbar.showSuccess('${AppKeys.exerciseAddedToList}: $listName');
    update();
  }

  /// Edits the name of the specified favorite list.
  /// [list] the favorite list to edit.
  Future<void> editListName(FavoriteList list) async {
    final result = await CustomInputDialog.show(
      title: AppKeys.editListName,
      hintText: AppKeys.newListName,
      initialValue: list.name,
    );

    if (result != null && result.isNotEmpty) {
      await _hiveService.updateListName(list, result);
      loadFavoriteLists();
      CustomFlushbar.showSuccess('${AppKeys.listNameUpdated}: $result');
    }
  }

  /// Deletes the specified favorite list.
  /// Shows a confirmation dialog before deleting the list.
  /// [list] the favorite list to delete.
  Future<void> deleteList(FavoriteList list) async {
    final confirm = await CustomDialog.show(
      title: AppKeys.deleteList,
      content: AppKeys.sureDelete,
      confirmColor: Colors.red,
    );

    if (confirm ?? false) {
      await _hiveService.deleteList(list);
      loadFavoriteLists();
      CustomFlushbar.showSuccess('${AppKeys.listDeleted}: ${list.name}');
    }
  }

  /// Removes an exercise from all favorite lists.
  /// [exerciseId] the unique identifier of the exercise to remove.
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
