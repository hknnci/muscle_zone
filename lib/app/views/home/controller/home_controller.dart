import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/app/services/cache/home_cache_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/constants.dart';
import 'package:muscle_zone/core/utils/service_helper.dart';

/// Controller for the home page, manages body parts and exercises.
class HomeController extends GetxController {
  /// Constructs a [HomeController] widget.
  HomeController(this._exerciseService, this._cacheService);

  final ExerciseService _exerciseService;
  final HomeCacheService _cacheService;
  final ServiceHelper _serviceHelper = ServiceHelper();

  /// Observable list of body parts available in the application.
  final RxList<String> bodyParts = <String>[].obs;

  /// Observable list of exercises for the selected body part.
  final RxList<BaseObjectModel> exercises = <BaseObjectModel>[].obs;

  /// Currently selected body part.
  final RxString selectedBodyPart = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBodyParts();
  }

  /// Fetches the list of body parts from the exercise service
  /// and updates [bodyParts].
  /// Removes cardio from the list and applies custom sorting order.
  Future<void> fetchBodyParts() async {
    final cachedBodyParts = _cacheService.getBodyPartsFromCache();
    if (cachedBodyParts != null) {
      bodyParts.value = cachedBodyParts;
      return;
    }

    await _serviceHelper.fetchData<String>(
      fetchFunction: _exerciseService.getBodyPartList,
      targetList: bodyParts,
      errorMessage: AppKeys.failedToLoadBodyParts,
    );

    // Removed Cardio part
    bodyParts
      ..removeWhere((part) => part == 'cardio')
      ..sort(
        (a, b) => Constants.customBodyPartsOrder
            .indexOf(a)
            .compareTo(Constants.customBodyPartsOrder.indexOf(b)),
      );

    _cacheService.cacheBodyParts(bodyParts);
  }

  /// Fetches exercises for the specified body part
  /// and updates [exercises] list.
  /// Sets [selectedBodyPart] to the specified [bodyPart].
  Future<void> fetchExercisesByBodyPart(String bodyPart) async {
    selectedBodyPart.value = bodyPart;

    final cachedExercises = _cacheService.getExercisesFromCache(bodyPart);
    if (cachedExercises != null) {
      exercises.value = cachedExercises;
      return;
    }

    await _serviceHelper.fetchData<BaseObjectModel>(
      fetchFunction: () => _exerciseService.getExercisesByBodyPart(bodyPart),
      targetList: exercises,
      errorMessage: AppKeys.failedToLoadExercises,
    );

    _cacheService.cacheExercises(bodyPart, exercises);
  }
}
