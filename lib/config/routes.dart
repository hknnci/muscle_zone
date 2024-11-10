import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home_view.dart';
import 'package:muscle_zone/app/views/onboarding/onboarding_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: "/",
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: "/home",
      page: () => const HomeView(),
    ),
  ];
}
