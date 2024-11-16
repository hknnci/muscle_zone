import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/constants/routes.dart';

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
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.newListController,
                  decoration: const InputDecoration(
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
        );
      }

      return ListView.builder(
        itemCount: controller.favoriteLists.length,
        itemBuilder: (context, index) {
          final list = controller.favoriteLists[index];
          return ListTile(
            title: Text(list.name),
            subtitle: Text('${list.exerciseIds.length} exercise'),
            trailing: Row(
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
            onTap: () => Get.toNamed<dynamic>(
              Routes.favoriteExercises,
              arguments: list,
            ),
          );
        },
      );
    });
  }
}
