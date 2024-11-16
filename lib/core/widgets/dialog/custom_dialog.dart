import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Color? confirmColor;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    this.cancelText = 'İptal',
    this.confirmText = 'Tamam',
    this.confirmColor,
  }) : super(key: key);

  static Future<bool?> show({
    required String title,
    required String content,
    String cancelText = 'İptal',
    String confirmText = 'Tamam',
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
