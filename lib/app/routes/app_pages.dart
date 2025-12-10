import 'package:get/get.dart';

import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/signup/bindings/signup_binding.dart';
import '../modules/auth/signup/views/signup_view.dart';
import '../modules/filterScreen/bindings/filter_screen_binding.dart';
import '../modules/filterScreen/views/filter_screen_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/personalize/bindings/personalize_binding.dart';
import '../modules/personalize/views/personalize_view.dart';
import '../modules/shapeselect/bindings/shapeselect_binding.dart';
import '../modules/shapeselect/views/shapeselect_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // 🔥 App starting route
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    // 🔥 Splash Screen
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    // 🔥 Onboarding Screen
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    // 🔥 Auth Login
    GetPage(
      name: _Paths.AUTH_LOGIN,
      page: () => const AuthLoginView(),
      binding: AuthLoginBinding(),
    ),

    // 🔥 Signup
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.PERSONALIZE,
      page: () =>  PersonalizeView(),
      binding: PersonalizeBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => FilterScreenView(),
      binding: FilterScreenBinding(),
    ),
    GetPage(
      name: _Paths.SHAPESELECT,
      page: () => const ShapeselectView(),
      binding: ShapeselectBinding(),
    ),
  ];
}
