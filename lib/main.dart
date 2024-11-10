import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/onboarding/onboarding_screen.dart';
import 'package:muscle_zone/config/routes.dart';
import 'package:muscle_zone/core/themes/theme.dart';

import 'app/bindings/app_binding.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Exercise App',
      theme: MaterialTheme(const TextTheme()).light(),
      initialBinding: AppBinding(),
      getPages: AppRoutes.pages,
      home: const OnboardingScreen(),
    );
  }
}
