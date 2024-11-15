import 'package:get/get.dart';
import 'package:muscle_zone/app/views/exercises/controller/exercises_controller.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';
import 'package:muscle_zone/app/views/onboarding/controller/onboarding_controller.dart';
import 'package:muscle_zone/app/views/splash/controller/splash_controller.dart';
import 'package:muscle_zone/app/services/exercise_service.dart';
import 'package:muscle_zone/config/app_service.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Core Services - Synchronously initializing core services
    Get.put(ApiClient());
    Get.put(SharedPrefService()).init();

    // Other Services
    Get.put(AppService(Get.find<SharedPrefService>()));
    Get.put(ExerciseService(Get.find<ApiClient>()));

    // Controllers
    Get.put(SplashController(Get.find<AppService>()));
    Get.lazyPut(
      () => OnboardingController(Get.find<SharedPrefService>()),
    );
    Get.lazyPut(() => HomeController(Get.find<ExerciseService>()));
    Get.lazyPut(
      () => ExercisesController(Get.find<ExerciseService>()),
      fenix: true,
    );
  }
}
