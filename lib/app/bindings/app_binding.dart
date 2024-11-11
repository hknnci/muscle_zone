import 'package:get/get.dart';
import 'package:muscle_zone/app/controllers/home_controller.dart';
import 'package:muscle_zone/app/controllers/onboarding_controller.dart';
import 'package:muscle_zone/app/controllers/splash_controller.dart';
import 'package:muscle_zone/app/services/exercise_service.dart';
import 'package:muscle_zone/app/services/local/app_service.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Core Services - Synchronously initializing basic services
    Get.put(ApiClient());

    // Initialize SharedPrefService immediately
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
  }
}
