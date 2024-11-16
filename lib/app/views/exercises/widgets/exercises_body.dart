import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';
import 'package:muscle_zone/core/widgets/progress/page_indicator.dart';

class ExercisesBody extends GetView<ExercisesController> {
  const ExercisesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredExercises.isEmpty) {
        return Center(
          child: CustomText.titleLarge(AppKeys.noExercise),
        );
      }

      return Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.filteredExercises.length,
              onPageChanged: controller.updatePageIndex,
              itemBuilder: (context, index) {
                final exercise = controller.filteredExercises[index];
                return _ExerciseContent(exercise: exercise);
              },
            ),
          ),

          // Loading indicator
          Obx(() {
            if (controller.isLoadingMore.value) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          }),

          // Page indicators
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                controller.filteredExercises.length,
                (index) => PageIndicator(
                  isActive: controller.currentPageIndex.value == index,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _ExerciseContent extends StatelessWidget {
  final BaseObjectModel exercise;

  const _ExerciseContent({Key? key, required this.exercise}) : super(key: key);

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
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return CustomText.bodyLarge(AppKeys.failedToLoadGif);
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
