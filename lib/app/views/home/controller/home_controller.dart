import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/core/constants/constants.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/utils/service_helper.dart';

class HomeController extends GetxController {
  final ExerciseService _exerciseService;
  final ServiceHelper _serviceHelper = ServiceHelper();

  HomeController(this._exerciseService);

  var bodyParts = <String>[].obs;
  var exercises = <BaseObjectModel>[].obs;
  var selectedBodyPart = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchBodyParts();
  }

  // Fetch Body Parts
  void fetchBodyParts() async {
    await _serviceHelper.fetchData<String>(
      fetchFunction: _exerciseService.getBodyPartList,
      targetList: bodyParts,
      errorMessage: AppKeys.failedToLoadBodyParts,
    );

    // Removed Cardio part
    bodyParts.removeWhere((part) => part == 'cardio');

    // Apply fixed custom body part order
    bodyParts.sort((a, b) {
      return Constants.customBodyPartsOrder
          .indexOf(a)
          .compareTo(Constants.customBodyPartsOrder.indexOf(b));
    });
  }

  // Fetch Exercises by Body Part
  void fetchExercisesByBodyPart(String bodyPart) async {
    selectedBodyPart.value = bodyPart;
    await _serviceHelper.fetchData<BaseObjectModel>(
      fetchFunction: () => _exerciseService.getExercisesByBodyPart(bodyPart),
      targetList: exercises,
      errorMessage: AppKeys.failedToLoadExercises,
    );
  }
}
