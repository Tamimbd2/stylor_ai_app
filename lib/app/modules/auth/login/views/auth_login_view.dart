import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/color.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../personalize/views/personalize_view.dart';
import '../controllers/auth_login_controller.dart';

class AuthLoginView extends StatefulWidget {
  const AuthLoginView({super.key});

  @override
  State<AuthLoginView> createState() => _AuthLoginViewState();
}

class _AuthLoginViewState extends State<AuthLoginView> {
  final AuthLoginController controller = Get.put(AuthLoginController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    if (controller.isRememberMe.value) {
      _emailController.text = controller.savedEmail.value;
      _passwordController.text = controller.savedPassword.value;
      _rememberMe = true;
    } else {
      _emailController.text = '';
      _passwordController.text = '';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                        'welcome_back'.tr,
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
                        'login_subtitle'.tr,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 40.h),

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
                      prefixIcon: Icons.email_outlined,
                      hintText: 'Enter your email',
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

                    if (_passwordError != null)
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          _passwordError!,
                          style: TextStyle(fontSize: 12.sp, color: Colors.red),
                        ),
                      ),

                    SizedBox(height: 8.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: const Offset(-5, 0), // থাকবে
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() => _rememberMe = value ?? false);
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
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),




                    SizedBox(height: 16.h),

                    AppButton(
                      text: "Sign In",
                      textColor: AppColors.primaryLight,
                      backgroundColor: AppColors.primaryDark,
                      onPressed: () async {
                        if (_validateForm()) {
                          setState(() => _isLoading = true);
                          final success = await controller.login(
                            _emailController.text.trim(),
                            _passwordController.text,
                            rememberMe: _rememberMe,
                          );
                          if (mounted) {
                            setState(() => _isLoading = false);
                            if (success) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonalizeView(),
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),

                    SizedBox(height: 16.h),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

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
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
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
                          onTap: () => _handleSocialSignIn('Google'),
                        ),
                        SizedBox(width: 16.w),
                        _buildSocialButton(
                          icon: SvgPicture.asset(
                            'assets/svg/apple.svg',
                            width: 22.w,
                            height: 22.w,
                          ),
                          label: 'Apple',
                          onTap: () => _handleSocialSignIn('Apple'),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/signup');
                            },

                            child: Text(
                              'Sign Up',
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
          // Loading Indicator Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(40.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 70.w,
                        height: 70.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Authenticating...',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please wait',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// VALIDATION METHOD
  bool _validateForm() {
    bool isValid = true;
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Email validation
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      isValid = false;
    } else if (!_isValidEmail(email)) {
      setState(() {
        _emailError = 'Please enter a valid email';
      });
      isValid = false;
    }

    // Password validation
    String password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      isValid = false;
    } else if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters';
      });
      isValid = false;
    }

    return isValid;
  }

  /// EMAIL VALIDATION
  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// INPUT FIELD
  Widget _buildInputField({
    required TextEditingController controller,
    required IconData prefixIcon,
    String hintText = '',
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: AppColors.neutral900),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
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
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline, color: AppColors.neutral900),
          hintText: 'Enter your password',
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
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

  /// HANDLE SOCIAL SIGN IN
  void _handleSocialSignIn(String provider) async {
    if (provider == 'Google') {
      setState(() => _isLoading = true);
      final success = await controller.handleGoogleSignIn();
      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalizeView(),
            ),
          );
        }
      }
      return;
    }

    setState(() => _isLoading = true);

    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      _showAccountSelectionDialog(provider);
    }
  }

  /// SHOW ACCOUNT SELECTION DIALOG
  void _showAccountSelectionDialog(String provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Account',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Choose account to continue with $provider',
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                _buildAccountOption('olivia@gmail.com'),
                SizedBox(height: 12.h),
                _buildAccountOption('olivia.brown@gmail.com'),
                SizedBox(height: 24.h),
                AppButton(
                  text: "Cancel",
                  textColor: Colors.black,
                  backgroundColor: Colors.grey[200]!,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// BUILD ACCOUNT OPTION
  Widget _buildAccountOption(String email) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logged in with $email'),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.primaryDark,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.primaryDark,
              child: Text(
                email[0].toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email.split('@')[0],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
