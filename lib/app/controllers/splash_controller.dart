import 'package:get/get.dart';
import 'package:muscle_zone/app/services/local/app_service.dart';
import 'package:muscle_zone/core/constants/routes.dart';

class SplashController extends GetxController {
  final AppService _appService;

  SplashController(this._appService);

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Get initial route and navigate
      final initialRoute = await _appService.getInitialRoute();
      Get.offAllNamed(initialRoute);
    } catch (e) {
      print('Error during initialization: $e');
      Get.offAllNamed(Routes.home);
    }
  }
}
