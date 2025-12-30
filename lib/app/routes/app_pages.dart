import 'package:get/get.dart';

import '../modules/EditProfile/bindings/edit_profile_binding.dart';
import '../modules/EditProfile/views/edit_profile_view.dart';
import '../modules/ProfileDetails/bindings/profile_details_binding.dart';
import '../modules/ProfileDetails/views/profile_details_view.dart';
import '../modules/auth/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/auth/forgot_password/views/forgot_password_view.dart';
import '../modules/auth/login/bindings/auth_login_binding.dart';
import '../modules/auth/login/views/auth_login_view.dart';
import '../modules/auth/otp/bindings/otp_binding.dart';
import '../modules/auth/otp/views/otp_view.dart';
import '../modules/auth/reset_password/bindings/reset_password_binding.dart';
import '../modules/auth/reset_password/views/reset_password_view.dart';
import '../modules/auth/signup/bindings/signup_binding.dart';
import '../modules/auth/signup/views/signup_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/filterScreen/bindings/filter_screen_binding.dart';
import '../modules/filterScreen/views/filter_screen_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/output_outfit/bindings/output_outfit_binding.dart';
import '../modules/output_outfit/views/output_outfit_view.dart';
import '../modules/personalize/bindings/personalize_binding.dart';
import '../modules/personalize/views/personalize_view.dart';
import '../modules/privacyPolicy/bindings/privacy_policy_binding.dart';
import '../modules/privacyPolicy/views/privacy_policy_view.dart';
import '../modules/productList/bindings/product_list_binding.dart';
import '../modules/productList/views/product_list_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/shapeselect/bindings/shapeselect_binding.dart';
import '../modules/shapeselect/views/shapeselect_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/takePhoto/bindings/take_photo_binding.dart';
import '../modules/takePhoto/views/take_photo_view.dart';
import '../modules/termsAndConditions/bindings/terms_and_conditions_binding.dart';
import '../modules/termsAndConditions/views/terms_and_conditions_view.dart';
import '../modules/wardrobe/bindings/wardrobe_binding.dart';
import '../modules/wardrobe/views/wardrobe_view.dart';
import '../modules/wardropDetails/bindings/wardrop_details_binding.dart';
import '../modules/wardropDetails/views/wardrop_details_view.dart';

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
      page: () => PersonalizeView(),
      binding: PersonalizeBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => FilterScreenView(),
      binding: FilterScreenBinding(),
    ),
    GetPage(
      name: _Paths.SHAPESELECT,
      page: () => ShapeselectView(),
      binding: ShapeselectBinding(),
    ),
    GetPage(
      name: _Paths.OUTPUT_OUTFIT,
      page: () => OutputOutfitView(),
      binding: OutputOutfitBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => const ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.WARDROBE,
      page: () => WardrobeView(),
      binding: WardrobeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () =>  LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_AND_CONDITIONS,
      page: () => const TermsAndConditionsView(),
      binding: TermsAndConditionsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.TAKE_PHOTO,
      page: () => TakePhotoView(),
      binding: TakePhotoBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_DETAILS,
      page: () => const ProfileDetailsView(),
      binding: ProfileDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.WARDROP_DETAILS,
      page: () => const WardropDetailsView(),
      binding: WardropDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () =>  ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
