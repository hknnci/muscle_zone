import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/buttons/filter_bottomsheet.dart';
import 'package:muscle_zone/core/widgets/page/exercises_page.dart';
import 'package:muscle_zone/core/widgets/progress/page_indicator.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

class ExercisesView extends GetView<ExercisesController> {
  final String bodyPart;

  const ExercisesView({Key? key, required this.bodyPart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      isHomeScreen: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: GradientText(
            "${AppKeys.exercisesTitle} ${bodyPart.toTitleCase()}",
            isAppBar: true,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showEquipmentFilterBottomSheet(context),
            ),
          ],
        ),
        body: Obx(() {
          // Show loading indicator only during the loading state
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // After loading, if no exercises are found, display a message
          if (controller.filteredExercises.isEmpty) {
            return Center(
              child: CustomText.titleLarge(AppKeys.noExercise),
            );
          }

          // In the normal case, display the exercises
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.filteredExercises.length,
                  onPageChanged: controller.updatePageIndex,
                  itemBuilder: (context, index) {
                    return ExercisesPage(
                      exercise: controller.filteredExercises[index],
                    );
                  },
                ),
              ),

              // Show loading indicator while loading more exercises
              Obx(() {
                if (controller.isLoadingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),

              // Page Indicator
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
        }),
      ),
    );
  }

  void _showEquipmentFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => EquipmentFilterBottomSheet(controller: controller),
    );
  }
}
