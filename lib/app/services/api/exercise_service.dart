import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

/// Service class that handles exercise-related API requests
class ExerciseService extends GetxService {
  /// Constructor for ExerciseService
  ExerciseService(this.apiClient);

  /// Client used to make API requests
  final ApiClient apiClient;

  /// Returns a list of all available body parts for exercises
  Future<List<String>> getBodyPartList() async => apiClient.getList<String>(
        path: DBConstants.path_bodyPartList,
      );

  /// Returns a list of all available equipment types for exercises
  Future<List<String>> getEquipmentList() async => apiClient.getList<String>(
        path: DBConstants.path_equipmentList,
      );

  /// Returns a list of all available target muscle groups for exercises
  Future<List<String>> getTargetList() async => apiClient.getList<String>(
        path: DBConstants.path_targetList,
      );

  /// Returns a list of exercises for a specific body part
  /// [bodyPart] specifies the target body part
  /// [limit] maximum number of results per page (default: 10)
  /// [offset] starting point for pagination (default: 0)
  Future<List<BaseObjectModel>> getExercisesByBodyPart(
    String bodyPart, {
    int limit = 10,
    int offset = 0,
  }) async =>
      apiClient.getList<BaseObjectModel>(
        path: '${DBConstants.path_bodyPart}/$bodyPart',
        queryParameters: {
          DBConstants.key_limit: '$limit',
          DBConstants.key_offset: '$offset',
        },
      );

  /// Returns a list of exercises for a specific equipment type
  /// [type] specifies the equipment type to filter by
  Future<List<BaseObjectModel>> getExercisesByEquipment(String type) async =>
      apiClient.getList<BaseObjectModel>(
        path: '${DBConstants.path_equipment}/$type',
      );

  /// Returns a list of exercises for a specific target muscle group
  /// [target] specifies the target muscle to filter by
  Future<List<BaseObjectModel>> getExercisesByTarget(String target) async =>
      apiClient.getList<BaseObjectModel>(
        path: '${DBConstants.path_target}/$target',
      );

  /// Returns a list of exercises matching the given name
  /// [name] specifies the exercise name to search for
  Future<List<BaseObjectModel>> getExercisesByName(String name) async =>
      apiClient.getList<BaseObjectModel>(
        path: '${DBConstants.path_name}/$name',
      );

  /// Returns exercise details for the specified ID
  /// [id] unique identifier of the exercise
  Future<BaseObjectModel> getExerciseById(String id) async =>
      apiClient.get<BaseObjectModel>(
        path: '${DBConstants.path_exercise}/$id',
      );
}
