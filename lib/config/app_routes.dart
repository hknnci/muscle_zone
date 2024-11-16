import 'package:get/get.dart';
import 'package:muscle_zone/app/models/local/favorite_list/favorite_list_model.dart';
import 'package:muscle_zone/app/views/exercises/view/exercises_view.dart';
import 'package:muscle_zone/app/views/favorite_exercises/view/favorite_exercises_view.dart';
import 'package:muscle_zone/app/views/favorite_list/view/favorite_list_view.dart';
import 'package:muscle_zone/app/views/home/view/home_view.dart';
import 'package:muscle_zone/app/views/onboarding/view/onboarding_view.dart';
import 'package:muscle_zone/app/views/splash/view/splash_view.dart';
import 'package:muscle_zone/core/constants/routes.dart';

/// Class that manages the application's page routes
class AppRoutes {
  /// Returns the list of pages for the application.
  static final pages = [
    GetPage<dynamic>(
      name: Routes.splash,
      page: () => const SplashView(),
    ),
    GetPage<dynamic>(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
    ),
    GetPage<dynamic>(
      name: Routes.home,
      page: () => const HomeView(),
    ),
    GetPage<dynamic>(
      name: Routes.exercises,
      page: () {
        final bodyPart = Get.arguments as String;
        return ExercisesView(bodyPart: bodyPart);
      },
    ),
    GetPage<dynamic>(
      name: Routes.favoriteLists,
      page: () => const FavoriteListView(),
    ),
    GetPage<dynamic>(
      name: Routes.favoriteExercises,
      page: () {
        final list = Get.arguments as FavoriteList;
        return FavoriteExercisesView(favoriteList: list);
      },
    ),
  ];
}
