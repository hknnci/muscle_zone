import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/utils/api_client.dart';
import '../models/exercise_model.dart';

class ExerciseService extends GetxService {
  final ApiClient apiClient;

  ExerciseService(this.apiClient);

  Future<List<ExerciseModel>> getBodyPart(String bodyPart) async =>
      await apiClient.get(
        path: DBConstants.path_bodyPart + "/$bodyPart",
        fromJson: (json) => ExerciseModel.fromJson(json),
      );
}
