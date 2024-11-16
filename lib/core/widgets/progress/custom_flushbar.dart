import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';

/// Helper class for managing snackbar notifications throughout the app
class CustomFlushbar {
  /// Displays an error message using a snackbar
  static void showError(String message) {
    Get.snackbar(
      AppKeys.error,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Displays a success message using a snackbar
  static void showSuccess(String message) {
    Get.snackbar(
      AppKeys.success,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Displays an info message using a snackbar
  static void showInfo(String message) {
    Get.snackbar(
      AppKeys.info,
      message,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
