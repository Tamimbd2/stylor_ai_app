import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/color.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../personalize/views/personalize_view.dart';
import '../../login/views/auth_login_view.dart';
import '../controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final SignupController controller = Get.put(SignupController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptPrivacy = false;
  bool _isLoading = false;

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _privacyError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),

                  /// Logo
                  Center(
                    child: Image.asset('assets/logo/logo.png', height: 55.h),
                  ),

                  SizedBox(height: 40.h),

                  Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Center(
                    child: Text(
                      'Login to access your account',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Text(
                    'Your Name',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  _buildInputField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    nextFocus: _emailFocus,
                    prefixIcon: Icons.person_outline,
                    hintText: 'Write Your Name',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  if (_nameError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Text(
                        _nameError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),

                  SizedBox(height: 16.h),

                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  _buildInputField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    nextFocus: _phoneFocus,
                    prefixIcon: Icons.email_outlined,
                    hintText: 'olivia@untitledui.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  if (_emailError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Text(
                        _emailError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),

                  SizedBox(height: 16.h),

                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  _buildPasswordField(),
                  SizedBox(height: 16.h),

                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  _buildConfirmPasswordField(),

                  if (_passwordError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Text(
                        _passwordError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                  if (_confirmPasswordError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: Text(
                        _confirmPasswordError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),

                  SizedBox(height: 16.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Checkbox(
                          value: _acceptPrivacy,
                          onChanged: (value) {
                            setState(() => _acceptPrivacy = value ?? false);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          fillColor: WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.black;
                            }
                            return Colors.transparent;
                          }),
                          checkColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _acceptPrivacy = !_acceptPrivacy);
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black87,
                              ),
                              children: [
                                const TextSpan(text: 'I agree to the '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    // decoration: TextDecoration.underline,
                                    color: Colors.black87,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed('/privacy-policy');
                                    },
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Terms of use',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    // decoration: TextDecoration.underline,
                                    color: Colors.black87,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed('/terms-and-conditions');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (_privacyError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        _privacyError!,
                        style: TextStyle(fontSize: 12.sp, color: Colors.red),
                      ),
                    ),

                  SizedBox(height: 24.h),

                  AppButton(
                    text: _isLoading ? "Signing Up..." : "Sign Up",
                    textColor: AppColors.primaryLight,
                    backgroundColor: AppColors.primaryDark,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthLoginView()));
                      if (!_isLoading) {
                        _handleSignUp();
                      }
                    },
                  ),

                  SizedBox(height: 32.h),

                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[300])),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  Center(
                    child: Text(
                      'Sign in with',
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon: SvgPicture.asset(
                          'assets/svg/google.svg',
                          width: 22.w,
                          height: 22.w,
                        ),
                        label: 'Google',
                        onTap: () => () {},
                      ),
                      SizedBox(width: 16.w),
                      _buildSocialButton(
                        icon: SvgPicture.asset(
                          'assets/svg/apple.svg',
                          width: 22.w,
                          height: 22.w,
                        ),
                        label: 'Apple',
                        onTap: () => () {},
                      ),
                    ],
                  ),

                  SizedBox(height: 32.h),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// INPUT FIELD
  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocus,
    required IconData prefixIcon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.neutral100),
          ),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: nextFocus != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (_) {
              if (nextFocus != null) {
                FocusScope.of(context).requestFocus(nextFocus);
              }
            },
            decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon, color: AppColors.neutral900),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// PASSWORD FIELD
  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: TextFormField(
        controller: _passwordController,
        focusNode: _passwordFocus,
        obscureText: _obscurePassword,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline, color: AppColors.neutral900),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
          hintText: '12345678',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  /// CONFIRM PASSWORD FIELD
  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        focusNode: _confirmPasswordFocus,
        obscureText: _obscureConfirmPassword,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          }
          if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline, color: AppColors.neutral900),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              );
            },
          ),
          hintText: 'Re-enter password',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  /// SOCIAL BUTTON
  Widget _buildSocialButton({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(child: icon),
      ),
    );
  }

  /// HANDLE SIGN UP
  void _handleSignUp() async {
    // Reset errors
    setState(() {
      _nameError = null;
      _emailError = null;
      _phoneError = null;
      _passwordError = null;
      _privacyError = null;
    });

    bool isValid = true;

    // Name validation
    if (_nameController.text.trim().isEmpty) {
      setState(() => _nameError = 'Please enter your name');
      isValid = false;
    }

    // Email validation
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _emailError = 'Please enter your email');
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      setState(() => _emailError = 'Please enter a valid email');
      isValid = false;
    }

    // Phone validation
    if (_phoneController.text.trim().isEmpty) {
      setState(() => _phoneError = 'Please enter your phone number');
      isValid = false;
    }

    // Password validation
    String password = _passwordController.text;
    if (password.isEmpty) {
      setState(() => _passwordError = 'Please enter your password');
      isValid = false;
    } else if (password.length < 8) {
      setState(() => _passwordError = 'Password must be at least 8 characters');
      isValid = false;
    }

    // If all fields are valid, then check privacy policy
    if (isValid && !_acceptPrivacy) {
      setState(
        () => _privacyError = 'Please accept Privacy Policy to continue',
      );
      return;
    }

    if (!isValid) {
      return;
    }

    // Show loading
    setState(() => _isLoading = true);

    // Simulate sign up delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Sign Up Successful!'),
          backgroundColor: AppColors.primaryDark,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate after delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalizeView()),
        );
      }
    }
  }
}
