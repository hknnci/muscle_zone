import 'package:muscle_zone/app/models/api/base_object_model.dart';

/// Utility class for converting JSON data to specific types
class JsonConverter {
  /// Generic fromJson converter based on Type
  static T fromJson<T>(dynamic json) {
    if (T == String) {
      return json as T;
    } else if (T == BaseObjectModel) {
      return BaseObjectModel.fromJson(json as Map<String, dynamic>) as T;
    }
    throw Exception('Unknown class for conversion');
  }
}
