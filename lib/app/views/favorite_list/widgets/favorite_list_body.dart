import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/routes.dart';
import 'package:muscle_zone/core/widgets/card/custom_card.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A widget that displays the body of the favorite list screen.
/// This includes a list of favorite exercise lists
/// and functionality to add new lists.
class FavoriteListBody extends StatelessWidget {
  /// Constructs a [FavoriteListBody] widget.
  const FavoriteListBody({required this.controller, super.key});

  /// The controller that manages the favorite list functionality.
  final FavoriteListController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isAddingNewList.value) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: CustomCard(
            bodyPart: '',
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.newListController,
                    decoration: InputDecoration(
                      hintText: AppKeys.listName,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: controller.saveNewList,
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: controller.favoriteLists.length,
        itemBuilder: (context, index) {
          final list = controller.favoriteLists[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: CustomCard(
              bodyPart: list.name,
              onTap: () => Get.toNamed<dynamic>(
                Routes.favoriteExercises,
                arguments: list,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.titleMedium(list.name),
                      CustomText.titleSmall(
                        '${list.exerciseIds.length} ${AppKeys.exercise}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => controller.editListName(list),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.deleteList(list),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
