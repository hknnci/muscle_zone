import 'package:flutter/material.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';

class ExercisesPage extends StatelessWidget {
  final BaseObjectModel exercise;

  const ExercisesPage({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            exercise.gifUrl,
            fit: BoxFit.cover,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              // GIF loading indicator
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return const Text("Failed to load GIF");
            },
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText.titleLarge(exercise.name.toTitleCase()),
              CustomText.bodyLarge(
                "${AppKeys.target} ${exercise.target.toTitleCase()}",
              ),
              const SizedBox(height: 8),
              CustomText.bodyLarge(
                "${AppKeys.equipment} ${exercise.equipment.toTitleCase()}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
