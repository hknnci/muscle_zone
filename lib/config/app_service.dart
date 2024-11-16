import 'package:get/get.dart';
import 'package:muscle_zone/app/services/local/shared_pref_service.dart';
import 'package:muscle_zone/core/constants/routes.dart';

/// Application service class that manages initial route
/// and other app-level services.
class AppService extends GetxService {
  /// Constructs an [AppService] instance.
  AppService(this._sharedPrefService);

  /// Shared preferences service instance
  final SharedPrefService _sharedPrefService;

  /// Gets the initial route based on the first launch status.
  Future<String> getInitialRoute() async {
    final isFirstLaunch = await _sharedPrefService.isFirstLaunch();
    return isFirstLaunch ? Routes.onboarding : Routes.home;
  }
}
