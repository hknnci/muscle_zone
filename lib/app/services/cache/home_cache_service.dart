import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';

/// Service class for caching data in the home screen.
class HomeCacheService extends GetxService {
  final Map<String, List<BaseObjectModel>> _exerciseCache = {};
  List<String>? _bodyPartsCache;

  /// Caches body parts.
  // ignore: use_setters_to_change_properties
  void cacheBodyParts(List<String> bodyParts) {
    _bodyPartsCache = bodyParts;
  }

  /// Retrieves body parts from the cache.
  List<String>? getBodyPartsFromCache() {
    return _bodyPartsCache;
  }

  /// Caches exercises by body part.
  void cacheExercises(String bodyPart, List<BaseObjectModel> exercises) {
    _exerciseCache[bodyPart] = exercises;
  }

  /// Retrieves exercises by body part from the cache.
  List<BaseObjectModel>? getExercisesFromCache(String bodyPart) {
    return _exerciseCache[bodyPart];
  }

  /// Clears the cache.
  void clearCache() {
    _exerciseCache.clear();
    _bodyPartsCache = null;
  }
}
