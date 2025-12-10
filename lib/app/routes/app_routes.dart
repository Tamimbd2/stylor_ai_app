part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const AUTH_LOGIN = _Paths.AUTH_LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const PERSONALIZE = _Paths.PERSONALIZE;
  static const FILTER_SCREEN = _Paths.FILTER_SCREEN;
  static const SHAPESELECT = _Paths.SHAPESELECT;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const AUTH_LOGIN = '/auth-login';
  static const SIGNUP = '/signup';
  static const PERSONALIZE = '/personalize';
  static const FILTER_SCREEN = '/filter-screen';
  static const SHAPESELECT = '/shapeselect';
}
