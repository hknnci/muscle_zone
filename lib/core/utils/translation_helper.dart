import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/api_translations.dart';

/// Helper class for translating exercise-related terms from the API
class TranslationHelper {
  /// Translates a body part based on device language
  static String translateBodyPart(String bodyPart) {
    // If the device language is Turkish, translate the body part
    return Get.locale?.languageCode == 'tr'
        ? ApiTranslations.bodyParts[bodyPart.toLowerCase()] ?? bodyPart
        : bodyPart;
  }

  /// Translates equipment based on device language
  static String translateEquipment(String equipment) {
    // If the device language is Turkish, translate the equipment
    return Get.locale?.languageCode == 'tr'
        ? ApiTranslations.equipment[equipment.toLowerCase()] ?? equipment
        : equipment;
  }

  /// Translates target muscle based on device language
  static String translateTarget(String target) {
    // If the device language is Turkish, translate the target
    return Get.locale?.languageCode == 'tr'
        ? ApiTranslations.targets[target.toLowerCase()] ?? target
        : target;
  }
}
