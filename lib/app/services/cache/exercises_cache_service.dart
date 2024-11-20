import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';

/// Service class for caching exercises data.
class ExercisesCacheService extends GetxService {
  final Map<String, List<BaseObjectModel>> _exercisesByBodyPartCache = {};
  final Map<String, List<String>> _filterListsCache = {};

  /// Caches exercises by body part.
  void cacheExercisesByBodyPart(
    String bodyPart,
    List<BaseObjectModel> exercises,
  ) {
    print('Cached ${exercises.length} exercises for body part: $bodyPart');
    _exercisesByBodyPartCache[bodyPart] = exercises;
  }

  /// Retrieves exercises by body part from the cache.
  List<BaseObjectModel>? getExercisesFromCache(String bodyPart) {
    final exercises = _exercisesByBodyPartCache[bodyPart];
    if (exercises != null) {
      print(
        'Retrieved ${exercises.length} exercises from cache '
        'for body part: $bodyPart',
      );
    } else {
      print('No cached exercises found for body part: $bodyPart');
    }
    return exercises;
  }

  /// Caches filter lists.
  void cacheFilterList(String key, List<String> list) {
    print('Cached filter list: $key with ${list.length} items');
    _filterListsCache[key] = list;
  }

  /// Retrieves a filter list from the cache.
  List<String>? getFilterListFromCache(String key) {
    final list = _filterListsCache[key];
    if (list != null) {
      print('Retrieved filter list from cache: $key with ${list.length} items');
    } else {
      print('No cached filter list found for key: $key');
    }
    return list;
  }

  /// Clears the cache.
  void clearCache() {
    _exercisesByBodyPartCache.clear();
    _filterListsCache.clear();
    print('Exercises cache cleared');
  }
}
