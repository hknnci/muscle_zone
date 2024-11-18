import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A dialog widget that displays and manages favorite exercise lists.
class FavoriteListDialog extends GetView<FavoriteListController> {
  /// Constructs a [FavoriteListDialog] widget.
  const FavoriteListDialog({
    required this.exerciseId,
    super.key,
  });

  /// The ID of the exercise to be added to the favorite list.
  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    controller.exerciseId = exerciseId;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText.titleLarge(AppKeys.favoriteLists),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back<void>(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Lists
            Flexible(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.favoriteLists.length,
                  itemBuilder: (context, index) {
                    final list = controller.favoriteLists[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.withAlpha(100)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            controller.addExerciseToList(list.name, exerciseId);
                            Get.back<void>();
                          },
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
            ),
            const SizedBox(height: 16),

            // Add new list section
            Obx(
              () => controller.isAddingNewList.value
                  ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.newListController,
                            decoration: InputDecoration(
                              hintText: AppKeys.newListName,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            controller.saveNewList();
                          },
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () => controller.startAddingNewList(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: CustomText.bodyMedium(
                        AppKeys.createNewList,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
