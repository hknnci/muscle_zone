import 'package:get/get.dart';
import 'package:muscle_zone/config/app_service.dart';
import 'package:muscle_zone/core/constants/routes.dart';

/// Controller for the splash screen.
class SplashController extends GetxController {
  /// Constructs a [SplashController] instance.
  SplashController(this._appService);

  /// The app service instance.
  final AppService _appService;

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 3));
      final initialRoute = await _appService.getInitialRoute();
      await Get.offAllNamed<dynamic>(initialRoute);
    } catch (e) {
      print('Error during initialization: $e');
      await Get.offAllNamed<dynamic>(Routes.home);
    }
  }
}
