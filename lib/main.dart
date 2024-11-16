// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/bindings/app_binding.dart';
import 'package:muscle_zone/config/app_routes.dart';
import 'package:muscle_zone/core/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MuscleZone',
      theme: const MaterialTheme(TextTheme()).light(),
      initialBinding: AppBinding(),
      defaultTransition: Transition.fade,
      getPages: AppRoutes.pages,
    );
  }
}
