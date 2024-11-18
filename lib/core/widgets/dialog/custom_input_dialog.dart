import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';

/// A customizable text input dialog widget.
class CustomInputDialog extends StatefulWidget {
  /// Constructs a [CustomInputDialog] widget.
  const CustomInputDialog({
    required this.title,
    required this.hintText,
    required this.initialValue,
    super.key,
    this.cancelText,
    this.confirmText,
  });

  /// The title text of the dialog
  final String title;

  /// The hint text of the dialog
  final String hintText;

  /// The initial value of the dialog
  final String initialValue;

  /// The text of the cancel button
  final String? cancelText;

  /// The text of the confirm button
  final String? confirmText;

  /// Shows the dialog and returns a string result.
  static Future<String?> show({
    required String title,
    required String hintText,
    String? initialValue,
  }) async {
    return Get.dialog<String>(
      CustomInputDialog(
        title: title,
        hintText: hintText,
        initialValue: initialValue ?? '',
      ),
    );
  }

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: widget.hintText),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back<String>(),
          child: Text(widget.cancelText ?? AppKeys.cancel),
        ),
        TextButton(
          onPressed: () => Get.back(result: _controller.text),
          child: Text(widget.confirmText ?? AppKeys.confirm),
        ),
      ],
    );
  }
}
