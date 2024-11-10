import 'package:muscle_zone/core/constants/db_constants.dart';

class ExerciseModel {
  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json[DBConstants.key_id] ?? "",
      name: json[DBConstants.key_name] ?? "",
      bodyPart: json[DBConstants.key_bodyPart] ?? "",
      equipment: json[DBConstants.key_equipment] ?? "",
      gifUrl: json[DBConstants.key_gifUrl] ?? "",
      target: json[DBConstants.key_target] ?? "",
      secondaryMuscles: List<String>.from(
        json[DBConstants.key_secondaryMuscles] ?? [],
      ),
      instructions: List<String>.from(
        json[DBConstants.key_instructions] ?? [],
      ),
    );
  }
}
