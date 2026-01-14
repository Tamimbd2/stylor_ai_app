# 🔍 Remaining Localization Tasks

## Files That Need `.tr` Added

### 1. **SignupView** - `lib/app/modules/auth/signup/views/signup_view.dart`

**Hardcoded Strings Found:**
- Line 87: `'Welcome Back'` → Should be `'Welcome Back'.tr`
- Line 100: `'Login to access your account'` → Should be `'Login Subtitle'.tr`
- Line 108: `'Your Name'` → Should be `'Your Name'.tr`
- Line 122: `'Write Your Name'` → Should be `'Write Your Name'.tr`
- Line 144: `'Email Address'` → Should be `'Email Address'.tr`
- Line 183: `'Password'` → Should be `'Password'.tr`
- Line 196: `'Confirm Password'` → Should be `'Confirm Password'.tr`
- Line 262: `'I agree to the '` → Should be `'I Agree To'.tr`
- Line 264: `'Privacy Policy'` → Should be `'Privacy Policy'.tr`
- Line 275: `' and '` → Should be `'And'.tr`
- Line 277: `'Terms of use'` → Should be `'Terms Of Use'.tr`
- Line 308: `'Signing Up...'` → Should be `'Signing Up'.tr`
- Line 308: `'Sign Up'` → Should be `'Sign Up'.tr`
- Line 326: `'OR'` → Should be `'OR'.tr`
- Line 342: `'Sign up with'` → Should be `'Sign In With'.tr`
- Line 386: `'Already have an account? '` → Should be `'Already Have Account'.tr`
- Line 395: `'Sign In'` → Should be `'Sign In'.tr`
- Line 549: `'Re-enter password'` → Should be `'Re-enter Password'.tr`

**Validation Messages:**
- Line 126, 162, 165, 480, 483, 527, 530: All validation messages
- Line 598, 605, 608, 617, 620, 626, 633: All error messages

### 2. **ForgotPasswordView** - `lib/app/modules/auth/forgot_password/views/forgot_password_view.dart`
Need to check for hardcoded strings.

### 3. **OtpView** - `lib/app/modules/auth/otp/views/otp_view.dart`
Need to check for hardcoded strings.

### 4. **ResetPasswordView** - `lib/app/modules/auth/reset_password/views/reset_password_view.dart`
Need to check for hardcoded strings.

### 5. **PersonalizeView** - `lib/app/modules/personalize/views/personalize_view.dart`
Need to check for hardcoded strings.

### 6. **ShapeSelectView** - `lib/app/modules/shapeselect/views/shapeselect_view.dart`
Need to check for hardcoded strings.

### 7. **OutputOutfitView** - `lib/app/modules/output_outfit/views/output_outfit_view.dart`
Need to check for hardcoded strings.

### 8. **FilterScreenView** - `lib/app/modules/filterScreen/views/filter_screen_view.dart`
Need to check for hardcoded strings.

### 9. **ProductListView** - `lib/app/modules/productList/views/product_list_view.dart`
- Line 13: `'ProductListView'` → Should be localized or removed

### 10. **TakePhotoView** - `lib/app/modules/takePhoto/views/take_photo_view.dart`
Need to check for hardcoded strings.

### 11. **WardropDetailsView** - `lib/app/modules/wardropDetails/views/wardrop_details_view.dart`
Need to check for hardcoded strings.

### 12. **PrivacyPolicyView** - `lib/app/modules/privacyPolicy/views/privacy_policy_view.dart`
Static content - may not need full localization.

### 13. **TermsAndConditionsView** - `lib/app/modules/termsAndConditions/views/terms_and_conditions_view.dart`
Static content - may not need full localization.

## ✅ Already Localized Views

1. ✅ **AuthLoginView** - Complete
2. ✅ **ProfileView** - Complete
3. ✅ **ProfileDetailsView** - Complete
4. ✅ **WardrobeView** - Complete
5. ✅ **FavoriteView** - Complete
6. ✅ **CartView** - Complete
7. ✅ **OnboardingView** - Complete
8. ✅ **LanguageView** - Complete
9. ✅ **EditProfileView** - Complete
10. ✅ **SplashView** - No text (logo only)
11. ✅ **MainNavigationView** - Icons only

## 📝 Translation Keys Needed

Add these to `app_translations.dart` if not already present:

```dart
// Signup specific
'Sign Up Successful': 'Sign Up Successful!',
'Signing Up': 'Signing Up...',

// Validation messages
'Name Required': 'Please enter your name',
'Email Required': 'Please enter your email',
'Valid Email Required': 'Please enter a valid email',
'Password Required': 'Please enter your password',
'Password Min Length': 'Password must be at least 8 characters',
'Confirm Password Required': 'Please confirm your password',
'Passwords Mismatch': 'Passwords do not match',
'Accept Privacy': 'Please accept Privacy Policy to continue',
```

## 🎯 Priority Order

### High Priority (User-facing, frequently used):
1. **SignupView** - Registration is critical
2. **ForgotPasswordView** - Password recovery
3. **OtpView** - Verification
4. **ResetPasswordView** - Password reset
5. **PersonalizeView** - User onboarding
6. **ShapeSelectView** - User preferences

### Medium Priority:
7. **OutputOutfitView** - Main feature
8. **FilterScreenView** - Product filtering
9. **ProductListView** - Product browsing
10. **TakePhotoView** - Camera interface
11. **WardropDetailsView** - Item details

### Low Priority (Static content):
12. **PrivacyPolicyView** - Legal text
13. **TermsAndConditionsView** - Legal text

## 🚀 Next Steps

1. Update SignupView with all `.tr` calls
2. Check and update auth-related views (Forgot Password, OTP, Reset Password)
3. Update PersonalizeView and ShapeSelectView
4. Update remaining feature views
5. Test all languages thoroughly

---
**Last Updated**: 2026-01-14
**Status**: 9/24 views fully localized (38%)
