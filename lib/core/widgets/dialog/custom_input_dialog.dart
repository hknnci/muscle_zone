import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';

/// A customizable text input dialog widget.
class CustomInputDialog extends StatelessWidget {
  /// Constructs a [CustomInputDialog] widget.
  const CustomInputDialog({
    required this.title,
    required this.hintText,
    required this.initialValue,
    super.key,
    this.cancelText = AppKeys.cancel,
    this.confirmText = AppKeys.confirm,
  });

  /// The title text of the dialog
  final String title;

  /// The hint text of the dialog
  final String hintText;

  /// The initial value of the dialog
  final String initialValue;

  /// The text of the cancel button
  final String cancelText;

  /// The text of the confirm button
  final String confirmText;

  /// Shows the dialog and returns a string result.
  static Future<String?> show({
    required String title,
    required String hintText,
    String? initialValue,
  }) async {
    final controller = TextEditingController(text: initialValue);

    try {
      return await Get.dialog<String>(
        AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back<String>(),
              child: const Text(AppKeys.cancel),
            ),
            TextButton(
              onPressed: () => Get.back(result: controller.text),
              child: const Text(AppKeys.confirm),
            ),
          ],
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initialValue);
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: Get.back<String>,
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Get.back(result: controller.text),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
