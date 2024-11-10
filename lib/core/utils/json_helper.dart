import 'package:muscle_zone/app/models/exercise_model.dart';

T fromJson<T>(Map<String, dynamic> json) {
  if (T == ExerciseModel) {
    return ExerciseModel.fromJson(json) as T;
  } else {
    throw Exception("Unknown model type");
  }
}
