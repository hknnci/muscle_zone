import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

class ExerciseService extends GetxService {
  final ApiClient apiClient;

  ExerciseService(this.apiClient);

  Future<List<String>> getBodyPartList() async {
    return await apiClient.getList<String>(
      path: DBConstants.path_bodyPartList,
    );
  }

  Future<List<String>> getEquipmentList() async {
    return await apiClient.getList<String>(
      path: DBConstants.path_equipmentList,
    );
  }

  Future<List<String>> getTargetList() async {
    return await apiClient.getList<String>(
      path: DBConstants.path_targetList,
    );
  }

  Future<List<BaseObjectModel>> getExercisesByBodyPart(String bodyPart) async {
    return await apiClient.getList<BaseObjectModel>(
      path: "${DBConstants.path_bodyPart}/$bodyPart",
    );
  }

  Future<List<BaseObjectModel>> getExercisesByEquipment(String type) async {
    return await apiClient.getList<BaseObjectModel>(
      path: "${DBConstants.path_equipment}/$type",
    );
  }

  Future<List<BaseObjectModel>> getExercisesByTarget(String target) async {
    return await apiClient.getList<BaseObjectModel>(
      path: "${DBConstants.path_target}/$target",
    );
  }

  Future<List<BaseObjectModel>> getExercisesByName(String name) async {
    return await apiClient.getList<BaseObjectModel>(
      path: "${DBConstants.path_name}/$name",
    );
  }

  Future<BaseObjectModel> getExerciseById(String id) async {
    return await apiClient.get<BaseObjectModel>(
      path: "${DBConstants.path_exercise}/$id",
    );
  }
}
