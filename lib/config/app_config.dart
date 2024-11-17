import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Application configuration constants
class AppConfig {
  /// Application name
  static const String appName = 'MuscleZone';

  /// RapidAPI key header
  static const String rapidApiKey = 'X-RapidAPI-Key';

  /// RapidAPI host header
  static const String rapidApiHost = 'X-RapidAPI-Host';

  /// API key
  static const String apiKey = 'API_KEY';

  /// API host
  static const String apiHost = 'API_HOST';

  /// Default language
  static const String defaultLanguage = 'en';

  /// Key for first launch
  static const String keyIsFirstLaunch = 'isFirstLaunch';

  /// Initialize app configurations
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await dotenv.load();
  }

  /// Get supported locales
  static List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('tr'),
      ];

  /// Get translations path
  static const String translationsPath = 'assets/translations';

  /// Get fallback locale
  static const Locale fallbackLocale = Locale('en');
}
