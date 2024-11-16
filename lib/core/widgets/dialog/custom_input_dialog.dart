import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String initialValue;
  final String cancelText;
  final String confirmText;

  const CustomInputDialog({
    Key? key,
    required this.title,
    required this.hintText,
    required this.initialValue,
    this.cancelText = 'İptal',
    this.confirmText = 'Kaydet',
  }) : super(key: key);

  static Future<String?> show({
    required String title,
    required String hintText,
    required String initialValue,
    String cancelText = 'İptal',
    String confirmText = 'Kaydet',
  }) {
    final controller = TextEditingController(text: initialValue);

    return Get.dialog<String>(
      AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Get.back(result: controller.text),
            child: Text(confirmText),
          ),
        ],
      ),
    ).whenComplete(() => controller.dispose());
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
          onPressed: () => Get.back(),
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
