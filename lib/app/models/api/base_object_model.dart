import 'package:json_annotation/json_annotation.dart';
import 'package:muscle_zone/core/utils/translation_helper.dart';

part 'base_object_model.g.dart';

/// Base model representing an exercise object.
@JsonSerializable()
class BaseObjectModel {
  /// Constructor for BaseObjectModel
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

  /// Creates a [BaseObjectModel] instance from a JSON map
  factory BaseObjectModel.fromJson(Map<String, dynamic> json) =>
      _$BaseObjectModelFromJson(json);

  /// Unique identifier of the object
  final String id;

  /// Name of the exercise
  final String name;

  /// Body part targeted by the exercise
  final String bodyPart;

  /// Equipment required for the exercise
  final String equipment;

  /// URL of the exercise demonstration gif
  final String gifUrl;

  /// Primary muscle targeted by the exercise
  final String target;

  /// List of secondary muscles worked during the exercise
  final List<String> secondaryMuscles;

  /// Step-by-step instructions for performing the exercise
  final List<String> instructions;

  /// Returns the translated body part name
  String get translatedBodyPart =>
      TranslationHelper.translateBodyPart(bodyPart);

  /// Returns the translated equipment name
  String get translatedEquipment =>
      TranslationHelper.translateEquipment(equipment);

  /// Returns the translated target muscle name
  String get translatedTarget => TranslationHelper.translateTarget(target);
}
