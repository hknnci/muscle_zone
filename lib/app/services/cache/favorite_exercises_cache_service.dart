import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';

/// Service class for caching favorite exercises data.
class FavoriteExercisesCacheService extends GetxService {
  final Map<String, BaseObjectModel> _exerciseCache = {};

  /// Caches an exercise by its ID.
  void cacheExercise(String id, BaseObjectModel exercise) {
    print('Exercise cached with ID: $id');
    _exerciseCache[id] = exercise;
  }

  /// Retrieves an exercise by its ID from the cache.
  BaseObjectModel? getExerciseFromCache(String id) {
    final exercise = _exerciseCache[id];
    if (exercise != null) {
      print('Getting exercise from cache with ID: $id');
    } else {
      print('No exercise in cache for ID: $id');
    }
    return exercise;
  }

  /// Clears the cache.
  void clearCache() {
    _exerciseCache.clear();
    print('Favorite exercises cache cleared');
  }
}
