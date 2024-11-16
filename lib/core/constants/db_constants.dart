// ignore_for_file: public_member_api_docs, constant_identifier_names
/// Constants class containing database-related values
class DBConstants {
  // Query Parameters
  static const String key_limit = 'limit';
  static const String key_offset = 'offset';

  // JSON Keys
  static const String key_id = 'id';
  static const String key_name = 'name';
  static const String key_bodyPart = 'bodyPart';
  static const String key_bodyPartList = 'bodyPartList';
  static const String key_exercise = 'exercise';
  static const String key_exercises = 'exercises';
  static const String key_equipment = 'equipment';
  static const String key_equipmentList = 'equipmentList';
  static const String key_gifUrl = 'gifUrl';
  static const String key_target = 'target';
  static const String key_targetList = 'targetList';
  static const String key_secondaryMuscles = 'secondaryMuscles';
  static const String key_instructions = 'instructions';

  // Endpoint Paths
  static const String path_exercises = '/$key_exercises';
  static const String path_bodyPart = '/$key_bodyPart';
  static const String path_bodyPartList = '/$key_bodyPartList';
  static const String path_equipmentList = '/$key_equipmentList';
  static const String path_targetList = '/$key_targetList';
  static const String path_equipment = '/$key_equipment';
  static const String path_target = '/$key_target';
  static const String path_exercise = '/$key_exercise';
  static const String path_name = '/$key_name';
}
