import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomText {
  static Widget labelLarge(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.labelLarge?.copyWith(
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }

  // Display Large
  static Widget displayLarge(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.displayLarge?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Display Medium
  static Widget displayMedium(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.displayMedium?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Display Small
  static Widget displaySmall(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.displaySmall?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Headline Large
  static Widget headlineLarge(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.headlineLarge?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Headline Medium
  static Widget headlineMedium(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.headlineMedium?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Headline Small
  static Widget headlineSmall(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.headlineSmall?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Title Large
  static Widget titleLarge(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.titleLarge?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Title Medium
  static Widget titleMedium(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.titleMedium?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Title Small
  static Widget titleSmall(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.titleSmall?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Body Large
  static Widget bodyLarge(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.bodyLarge?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Body Medium
  static Widget bodyMedium(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.bodyMedium?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }

  // Body Small
  static Widget bodySmall(
    String text, {
    TextAlign textAlign = TextAlign.center,
    Color? color,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: Get.textTheme.bodySmall?.copyWith(
        color: color ?? Get.theme.colorScheme.onSurface,
      ),
    );
  }
}
