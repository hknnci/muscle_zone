import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService extends GetxService {
  static const String keyIsFirstLaunch = "isFirstLaunch";
  late SharedPreferences _prefs;

  Future<SharedPrefService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> isFirstLaunch() async {
    return _prefs.getBool(keyIsFirstLaunch) ?? true;
  }

  Future<void> setFirstLaunchCompleted() async {
    await _prefs.setBool(keyIsFirstLaunch, false);
  }
}
