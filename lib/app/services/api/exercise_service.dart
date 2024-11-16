import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

class ExerciseService extends GetxService {
  final ApiClient apiClient;

  ExerciseService(this.apiClient);

  Future<List<String>> getBodyPartList() async =>
      await apiClient.getList<String>(
        path: DBConstants.path_bodyPartList,
      );

  Future<List<String>> getEquipmentList() async =>
      await apiClient.getList<String>(
        path: DBConstants.path_equipmentList,
      );

  Future<List<String>> getTargetList() async => await apiClient.getList<String>(
        path: DBConstants.path_targetList,
      );

  Future<List<BaseObjectModel>> getExercisesByBodyPart(
    String bodyPart, {
    int limit = 10,
    int offset = 0,
  }) async =>
      await apiClient.getList<BaseObjectModel>(
        path: "${DBConstants.path_bodyPart}/$bodyPart",
        queryParameters: {
          DBConstants.key_limit: "$limit",
          DBConstants.key_offset: "$offset",
        },
      );

  Future<List<BaseObjectModel>> getExercisesByEquipment(String type) async =>
      await apiClient.getList<BaseObjectModel>(
        path: "${DBConstants.path_equipment}/$type",
      );

  Future<List<BaseObjectModel>> getExercisesByTarget(String target) async =>
      await apiClient.getList<BaseObjectModel>(
        path: "${DBConstants.path_target}/$target",
      );

  Future<List<BaseObjectModel>> getExercisesByName(String name) async =>
      await apiClient.getList<BaseObjectModel>(
        path: "${DBConstants.path_name}/$name",
      );

  Future<BaseObjectModel> getExerciseById(String id) async =>
      await apiClient.get<BaseObjectModel>(
        path: "${DBConstants.path_exercise}/$id",
      );
}
