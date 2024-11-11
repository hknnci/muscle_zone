import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/view/home_view.dart';
import 'package:muscle_zone/app/views/onboarding/view/onboarding_view.dart';
import 'package:muscle_zone/app/views/splash/view/splash_view.dart';
import 'package:muscle_zone/core/constants/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
    ),
  ];
}
