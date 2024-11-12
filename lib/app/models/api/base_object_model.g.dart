// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_object_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseObjectModel _$BaseObjectModelFromJson(Map<String, dynamic> json) =>
    BaseObjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      bodyPart: json['bodyPart'] as String,
      equipment: json['equipment'] as String,
      gifUrl: json['gifUrl'] as String,
      target: json['target'] as String,
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BaseObjectModelToJson(BaseObjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bodyPart': instance.bodyPart,
      'equipment': instance.equipment,
      'gifUrl': instance.gifUrl,
      'target': instance.target,
      'secondaryMuscles': instance.secondaryMuscles,
      'instructions': instance.instructions,
    };
