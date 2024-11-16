import 'package:hive_flutter/hive_flutter.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';

class HiveService {
  static const String favoritesBoxName = 'favorites';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FavoriteListAdapter());
    await Hive.openBox<FavoriteList>(favoritesBoxName);
  }

  Box<FavoriteList> getFavoritesBox() {
    return Hive.box<FavoriteList>(favoritesBoxName);
  }

  Future<void> addFavoriteList(FavoriteList list) async {
    final box = getFavoritesBox();
    await box.add(list);
  }

  Future<void> addExerciseToList(String listName, String exerciseId) async {
    final box = getFavoritesBox();
    final list = box.values.firstWhere((element) => element.name == listName);
    list.exerciseIds.add(exerciseId);
    await list.save();
  }

  bool isExerciseInAnyList(String exerciseId) {
    final box = getFavoritesBox();
    return box.values.any((list) => list.exerciseIds.contains(exerciseId));
  }

  Future<void> updateListName(FavoriteList list, String newName) async {
    list.name = newName;
    await list.save();
  }

  Future<void> deleteList(FavoriteList list) async {
    final box = getFavoritesBox();
    final key = box.keyAt(box.values.toList().indexOf(list));
    await box.delete(key);
  }

  Future<void> removeExerciseFromList(
      FavoriteList list, String exerciseId) async {
    list.exerciseIds.remove(exerciseId);
    await list.save();
  }
}
