import 'package:json_annotation/json_annotation.dart';

part 'base_object_model.g.dart';

@JsonSerializable()
class BaseObjectModel {
  final String id;
  final String name;
  final String bodyPart;
  final String equipment;
  final String gifUrl;
  final String target;
  final List<String> secondaryMuscles;
  final List<String> instructions;

  const BaseObjectModel({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
    required this.target,
    required this.secondaryMuscles,
    required this.instructions,
  });

  factory BaseObjectModel.fromJson(Map<String, dynamic> json) =>
      _$BaseObjectModelFromJson(json);
}
