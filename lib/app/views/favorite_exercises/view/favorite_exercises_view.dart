import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/views/favorite_exercises/controller/favorite_exercises_controller.dart';
import 'package:muscle_zone/app/views/favorite_exercises/widgets/favorite_exercise_body.dart';
import 'package:muscle_zone/core/widgets/background/gradient_background.dart';
import 'package:muscle_zone/core/widgets/texts/gradient_text.dart';

/// View widget that displays the favorite exercise list
class FavoriteExercisesView extends GetView<FavoriteExercisesController> {
  /// Constructor for FavoriteExercisesView
  const FavoriteExercisesView({required this.favoriteList, super.key});

  /// The favorite list to be displayed
  final FavoriteList favoriteList;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      isHomeScreen: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: GradientText(favoriteList.name, isAppBar: true),
        ),
        body: const FavoriteExercisesBody(),
      ),
    );
  }
}
