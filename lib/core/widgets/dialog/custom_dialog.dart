import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';

/// A customizable dialog widget.
/// Allows customization of title, content and button texts.
class CustomDialog extends StatelessWidget {
  /// Constructs a [CustomDialog] widget.
  const CustomDialog({
    required this.title,
    required this.content,
    this.cancelText = AppKeys.cancel,
    this.confirmText = AppKeys.confirm,
    this.confirmColor,
    super.key,
  });

  /// The title text of the dialog
  final String title;

  /// The content text of the dialog
  final String content;

  /// The text of the cancel button
  final String cancelText;

  /// The text of the confirm button
  final String confirmText;

  /// The color of the confirm button
  final Color? confirmColor;

  /// Shows the dialog and returns a boolean result.
  static Future<bool?> show({
    required String title,
    required String content,
    String cancelText = AppKeys.cancel,
    String confirmText = AppKeys.confirm,
    Color? confirmColor,
  }) {
    return Get.dialog<bool>(
      CustomDialog(
        title: title,
        content: content,
        cancelText: cancelText,
        confirmText: confirmText,
        confirmColor: confirmColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          style: confirmColor != null
              ? TextButton.styleFrom(foregroundColor: confirmColor)
              : null,
          child: Text(confirmText),
        ),
      ],
    );
  }
}
