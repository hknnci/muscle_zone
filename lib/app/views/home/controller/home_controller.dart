import 'package:get/get.dart';

import '../../../models/exercise_model.dart';
import '../../../services/exercise_service.dart';

class HomeController extends GetxController {
  final ExerciseService _exerciseService;

  HomeController(this._exerciseService);

  final _exercises = <ExerciseModel>[].obs;
  final _selectedBodyPart = "all".obs;

  List<ExerciseModel> get exercises => _exercises;
  String get selectedBodyPart => _selectedBodyPart.value;

  @override
  void onInit() {
    super.onInit();
    loadExercises();
  }

  void loadExercises([String? bodyPart]) async {
    try {
      _exercises.value = await _exerciseService.getBodyPart(bodyPart ?? "all");
      _selectedBodyPart.value = bodyPart ?? "all";
    } catch (e) {
      Get.snackbar("Error", "Failed to load exercises");
    }
  }

  void filterByBodyPart(String? bodyPart) {
    if (bodyPart != null) {
      loadExercises(bodyPart);
    }
  }
}
