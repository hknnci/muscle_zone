import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home_view.dart';
import 'package:muscle_zone/app/views/onboarding/onboarding_screen.dart';
import 'package:muscle_zone/app/views/splash/splash_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/onboarding',
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomeView(),
    ),
  ];
}
