import 'package:get/get.dart';
import 'package:muscle_zone/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService extends GetxService {
  late SharedPreferences _prefs;

  Future<SharedPrefService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> isFirstLaunch() async {
    return _prefs.getBool(AppConfig.keyIsFirstLaunch) ?? true;
  }

  Future<void> setFirstLaunchCompleted() async {
    await _prefs.setBool(AppConfig.keyIsFirstLaunch, false);
  }
}
