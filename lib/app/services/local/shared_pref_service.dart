import 'package:get/get.dart';
import 'package:muscle_zone/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service class that manages local storage operations
/// throughout the application.
class SharedPrefService extends GetxService {
  late SharedPreferences _prefs;

  /// Initializes the SharedPreferences instance.
  /// Returns the current SharedPrefService instance.
  Future<SharedPrefService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// Checks if the application is being launched for the first time.
  /// Returns true if it's the first launch, false otherwise.
  Future<bool> isFirstLaunch() async {
    return _prefs.getBool(AppConfig.keyIsFirstLaunch) ?? true;
  }

  /// Marks the first launch as completed and saves this value to local storage.
  Future<void> setFirstLaunchCompleted() async {
    await _prefs.setBool(AppConfig.keyIsFirstLaunch, false);
  }
}
