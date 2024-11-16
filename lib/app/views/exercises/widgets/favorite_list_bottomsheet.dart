import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';

class FavoriteListsBottomSheet extends GetView<FavoriteListController> {
  final String exerciseId;

  const FavoriteListsBottomSheet({
    Key? key,
    required this.exerciseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Favori Listeler',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.favoriteLists.length,
                itemBuilder: (context, index) {
                  final list = controller.favoriteLists[index];
                  return ListTile(
                    title: Text(list.name),
                    onTap: () =>
                        controller.addExerciseToList(list.name, exerciseId),
                  );
                },
              )),
          const SizedBox(height: 16),
          Obx(() => controller.isAddingNewList.value
              ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.newListController,
                        decoration: const InputDecoration(
                          hintText: 'Liste Adı',
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
                  child: const Text('Yeni Liste Oluştur'),
                )),
        ],
      ),
    );
  }
}
