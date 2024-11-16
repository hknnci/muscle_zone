import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A bottom sheet widget that displays and manages favorite exercise lists.
class FavoriteListsBottomSheet extends GetView<FavoriteListController> {
  /// Constructs a [FavoriteListsBottomSheet] widget.
  const FavoriteListsBottomSheet({
    required this.exerciseId,
    super.key,
  });

  /// The ID of the exercise to add to the favorite lists.
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText.titleLarge(AppKeys.favoriteLists),
          const SizedBox(height: 16),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.favoriteLists.length,
              itemBuilder: (context, index) {
                final list = controller.favoriteLists[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.withAlpha(100),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      onTap: () => controller.addExerciseToList(
                        list.name,
                        exerciseId,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      title: CustomText.titleMedium(
                        list.name,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => controller.isAddingNewList.value
                ? Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.newListController,
                          decoration: const InputDecoration(
                            hintText: AppKeys.newListName,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () => controller.saveNewList(),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () => controller.startAddingNewList(),
                    child: CustomText.bodyMedium(
                      AppKeys.createNewList,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
