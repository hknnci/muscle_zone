import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/app/views/exercises/widgets/exercises_body.dart';
import 'package:muscle_zone/app/views/exercises/widgets/favorite_button.dart';
import 'package:muscle_zone/app/views/exercises/widgets/filter_bottomsheet.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

/// A view widget that displays exercises for a specific body part.
class ExercisesView extends GetView<ExercisesController> {
  /// Constructs an [ExercisesView] widget.
  const ExercisesView({required this.bodyPart, super.key});

  /// The body part for which exercises will be displayed.
  final String bodyPart;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      isHomeScreen: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: GradientText(
            bodyPart.toTitleCase(),
            isAppBar: true,
          ),
          actions: [
            FavoriteButton(controller: controller),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showEquipmentFilterBottomSheet(context),
            ),
          ],
        ),
        body: const ExercisesBody(),
      ),
    );
  }

  void _showEquipmentFilterBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => EquipmentFilterBottomSheet(controller: controller),
    );
  }
}
