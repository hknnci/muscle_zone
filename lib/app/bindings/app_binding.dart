// ignore_for_file: cascade_invocations

import 'package:get/get.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/app/services/cache/exercises_cache_service.dart';
import 'package:muscle_zone/app/services/cache/favorite_exercises_cache_service.dart';
import 'package:muscle_zone/app/services/cache/home_cache_service.dart';
import 'package:muscle_zone/app/services/local/hive_service.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/app/views/favorite_exercises/controller/favorite_exercises_controller.dart';
import 'package:muscle_zone/app/views/favorite_list/controller/favorite_list_controller.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';
import 'package:muscle_zone/app/views/onboarding/controller/onboarding_controller.dart';
import 'package:muscle_zone/app/views/splash/controller/splash_controller.dart';
import 'package:muscle_zone/config/app_service.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

/// Binding class that registers all dependencies at app startup.
class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Core Services - Synchronously initializing core services
    Get.put(ApiClient());
    Get.put(SharedPrefService()).init();
    Get.put(HiveService()).init();

    // Cache Service
    Get.put(HomeCacheService(), permanent: true);
    Get.put(FavoriteExercisesCacheService(), permanent: true);
    Get.put(ExercisesCacheService(), permanent: true);

    // Other Services
    Get.put(AppService(Get.find<SharedPrefService>()));
    Get.put(ExerciseService(Get.find<ApiClient>()));

    // Controllers
    Get.put(SplashController(Get.find<AppService>()));
    Get.lazyPut(() => OnboardingController(Get.find<SharedPrefService>()));
    Get.lazyPut(
      () => HomeController(
        Get.find<ExerciseService>(),
        Get.find<HomeCacheService>(),
      ),
    );
    Get.lazyPut(
      () => ExercisesController(
        Get.find<ExerciseService>(),
        Get.find<ExercisesCacheService>(),
        bodyPart: Get.arguments as String? ?? '',
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => FavoriteListController(
        Get.find<HiveService>(),
        exerciseId: '',
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => FavoriteExercisesController(
        Get.find<HiveService>(),
        Get.find<ExerciseService>(),
        Get.find<FavoriteExercisesCacheService>(),
      ),
      fenix: true,
    );
  }
}
