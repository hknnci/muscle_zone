import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/views/favorite_exercises/controller/favorite_exercises_controller.dart';
import 'package:muscle_zone/app/views/favorite_exercises/widgets/favorite_exercise_body.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

class FavoriteExercisesView extends GetView<FavoriteExercisesController> {
  const FavoriteExercisesView({Key? key, required FavoriteList favoriteList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteList list = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GradientText(list.name, isAppBar: true),
      ),
      body: const FavoriteExercisesBody(),
    );
  }
}
