import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/app/views/favorite_list/widgets/favorite_list_body.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

class FavoriteListView extends GetView<FavoriteListController> {
  const FavoriteListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(AppKeys.favoriteLists, isAppBar: true),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => controller.startAddingNewList(),
          ),
        ],
      ),
      body: FavoriteListBody(controller: controller),
    );
  }
}