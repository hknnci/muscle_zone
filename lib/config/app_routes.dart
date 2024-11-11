import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home_view.dart';
import 'package:muscle_zone/app/views/onboarding/onboarding_screen.dart';
import 'package:muscle_zone/app/views/splash/splash_screen.dart';
import 'package:muscle_zone/core/constants/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
    ),
  ];
}
