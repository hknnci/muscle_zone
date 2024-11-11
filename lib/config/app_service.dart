import 'package:get/get.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/constants/routes.dart';

class AppService extends GetxService {
  final SharedPrefService _sharedPrefService;

  AppService(this._sharedPrefService);

  Future<String> getInitialRoute() async {
    final isFirstLaunch = await _sharedPrefService.isFirstLaunch();
    return isFirstLaunch ? Routes.onboarding : Routes.home;
  }
}
