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
  static const OUTPUT_OUTFIT = _Paths.OUTPUT_OUTFIT;
  static const FAVORITE = _Paths.FAVORITE;
  static const PRODUCT_LIST = _Paths.PRODUCT_LIST;
  static const CART = _Paths.CART;
  static const WARDROBE = _Paths.WARDROBE;
  static const PROFILE = _Paths.PROFILE;
  static const LANGUAGE = _Paths.LANGUAGE;
  static const TERMS_AND_CONDITIONS = _Paths.TERMS_AND_CONDITIONS;
  static const PRIVACY_POLICY = _Paths.PRIVACY_POLICY;
  static const TAKE_PHOTO = _Paths.TAKE_PHOTO;
  static const PROFILE_DETAILS = _Paths.PROFILE_DETAILS;
  static const EDIT_PROFILE = _Paths.EDIT_PROFILE;
  static const WARDROP_DETAILS = _Paths.WARDROP_DETAILS;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const AUTH_LOGIN = '/auth-login';
  static const SIGNUP = '/signup';
  static const PERSONALIZE = '/personalize';
  static const FILTER_SCREEN = '/filter-screen';
  static const SHAPESELECT = '/shapeselect';
  static const OUTPUT_OUTFIT = '/output-outfit';
  static const FAVORITE = '/favorite';
  static const PRODUCT_LIST = '/product-list';
  static const CART = '/cart';
  static const WARDROBE = '/wardrobe';
  static const PROFILE = '/profile';
  static const LANGUAGE = '/language';
  static const TERMS_AND_CONDITIONS = '/terms-and-conditions';
  static const PRIVACY_POLICY = '/privacy-policy';
  static const TAKE_PHOTO = '/take-photo';
  static const PROFILE_DETAILS = '/profile-details';
  static const EDIT_PROFILE = '/edit-profile';
  static const WARDROP_DETAILS = '/wardrop-details';
}
