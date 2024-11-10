import 'package:get/get.dart';
import 'package:muscle_zone/app/controllers/home_controller.dart';
import 'package:muscle_zone/app/controllers/onboarding_controller.dart';
import 'package:muscle_zone/app/services/exercise_service.dart';
import 'package:muscle_zone/core/utils/api_client.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // For API Client
    Get.lazyPut<ApiClient>(() => ApiClient());
    Get.lazyPut<ExerciseService>(() => ExerciseService(Get.find<ApiClient>()));

    // For Controllers
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<ExerciseService>()),
    );
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
