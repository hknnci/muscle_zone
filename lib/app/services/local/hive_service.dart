import 'package:hive_flutter/hive_flutter.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';

/// Service class that manages Hive database operations.
/// Handles local storage of favorite exercise lists.
class HiveService {
  /// Name of the Hive box for favorite lists.
  static const String favoritesBoxName = 'favorites';

  /// Initializes Hive database and registers required adapters.
  /// Must be called before any other Hive operations.
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FavoriteListAdapter());
    await Hive.openBox<FavoriteList>(favoritesBoxName);
  }

  /// Returns the Hive box containing favorite lists.
  Box<FavoriteList> getFavoritesBox() {
    return Hive.box<FavoriteList>(favoritesBoxName);
  }

  /// Adds a new favorite list to the Hive box.
  /// Takes a [FavoriteList] object as parameter and stores it in the database.
  Future<void> addFavoriteList(FavoriteList list) async {
    final box = getFavoritesBox();
    await box.add(list);
  }

  /// Adds an exercise to the specified favorite list.
  /// [listName] is the name of the list to add the exercise to.
  /// [exerciseId] is the unique identifier of the exercise to add.
  Future<void> addExerciseToList(String listName, String exerciseId) async {
    final box = getFavoritesBox();
    final list = box.values.firstWhere((element) => element.name == listName);
    list.exerciseIds.add(exerciseId);
    await list.save();
  }

  /// Checks if the given exercise ID exists in any favorite list.
  /// [exerciseId] is the unique identifier of the exercise to check.
  /// Returns true if the exercise is in any list, false otherwise.
  bool isExerciseInAnyList(String exerciseId) {
    final box = getFavoritesBox();
    return box.values.any((list) => list.exerciseIds.contains(exerciseId));
  }

  /// Updates the name of a favorite list.
  /// [list] is the FavoriteList to update.
  /// [newName] is the new name to set for the list.
  Future<void> updateListName(FavoriteList list, String newName) async {
    list.name = newName;
    await list.save();
  }

  /// Deletes the specified favorite list from the database.
  /// [list] is the favorite list to be deleted.
  Future<void> deleteList(FavoriteList list) async {
    final box = getFavoritesBox();
    final key = box.keyAt(box.values.toList().indexOf(list));
    await box.delete(key);
  }

  /// Removes an exercise from the specified favorite list.
  /// [list] is the favorite list to remove the exercise from.
  /// [exerciseId] is the unique identifier of the exercise to remove.
  Future<void> removeExerciseFromList(
    FavoriteList list,
    String exerciseId,
  ) async {
    list.exerciseIds.remove(exerciseId);
    await list.save();
  }
}
