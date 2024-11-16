import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/constants.dart';
import 'package:muscle_zone/core/utils/service_helper.dart';

/// Controller for the home page, manages body parts and exercises.
class HomeController extends GetxController {
  /// Constructs a [HomeController] widget.
  HomeController(this._exerciseService);

  final ExerciseService _exerciseService;
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
  }

  /// Fetches exercises for the specified body part
  /// and updates [exercises] list.
  /// Sets [selectedBodyPart] to the specified [bodyPart].
  Future<void> fetchExercisesByBodyPart(String bodyPart) async {
    selectedBodyPart.value = bodyPart;
    await _serviceHelper.fetchData<BaseObjectModel>(
      fetchFunction: () => _exerciseService.getExercisesByBodyPart(bodyPart),
      targetList: exercises,
      errorMessage: AppKeys.failedToLoadExercises,
    );
  }
}
