import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';

class CustomFlushbar {
  static showError(String message) {
    Get.snackbar(
      AppKeys.error,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static showSuccess(String message) {
    Get.snackbar(
      AppKeys.success,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
