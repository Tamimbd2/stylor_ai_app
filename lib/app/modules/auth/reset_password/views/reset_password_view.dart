import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widgets/primary_button.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  String? newPasswordError;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: const Color(0xFF1C1C1E),
                    size: 50.sp,
                  ),
                ),
                SizedBox(height: 24.h),

                // Success Title
                Text(
                  'Password Reset Successful'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1C1C1E),
                    fontSize: 20.sp,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
                SizedBox(height: 12.h),

                // Success Message
                Text(
                  'Password Reset Success Message'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF101C2C),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                ),
                SizedBox(height: 32.h),

                // Login Button
                AppButton(
                  text: 'Sign In'.tr,
                  textColor: Colors.white,
                  backgroundColor: const Color(0xFF060017),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Get.offAllNamed('/auth-login'); // Navigate to login screen
                    // Alternative if you don't use named routes:
                    // Get.offAll(() => LoginView());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              Center(child: Image.asset('assets/logo/logo.png', height: 50.h)),
              SizedBox(height: 40.h),
              Text(
                'Reset Your Password'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF1C1C1E),
                  fontSize: 24.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Password Must Be Different'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF101C2C),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
              SizedBox(height: 40.h),

              /// NEW PASSWORD INPUT
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password'.tr,
                    style: TextStyle(
                      color: const Color(0xFF1C1C1E),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.56,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                        () => _PasswordInputField(
                      controller: controller.newPasswordController,
                      hintText: '12345678',
                      isObscure: controller.isNewPasswordHidden.value,
                      onToggleVisibility: () {
                        controller.isNewPasswordHidden.toggle();
                      },
                    ),
                  ),
                  if (newPasswordError != null)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h, left: 4.w),
                      child: Text(
                        newPasswordError!,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 16.h),

              /// CONFIRM PASSWORD INPUT
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password'.tr,
                    style: TextStyle(
                      color: const Color(0xFF1C1C1E),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.56,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                        () => _PasswordInputField(
                      controller: controller.confirmPasswordController,
                      hintText: '12345678',
                      isObscure: controller.isConfirmPasswordHidden.value,
                      onToggleVisibility: () {
                        controller.isConfirmPasswordHidden.toggle();
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 200.h),

              /// RESET PASSWORD BUTTON
              /// RESET PASSWORD BUTTON
              Obx(() => AppButton(
                text: controller.isLoading.value ? 'Loading'.tr : 'Reset Password'.tr,
                textColor: Colors.white,
                backgroundColor: const Color(0xFF060017),
                onPressed: controller.isLoading.value ? () {} : () async {
                  setState(() {
                    final pwd = controller.newPasswordController.text;
                    final confirmPwd = controller.confirmPasswordController.text;

                    if (pwd.isEmpty) {
                      newPasswordError = 'Password Required'.tr;
                    } else if (pwd.length < 8) {
                      newPasswordError = 'Password Min Length'.tr;
                    } else if (pwd != confirmPwd) {
                      newPasswordError = 'Passwords Mismatch'.tr;
                    } else {
                      newPasswordError = null;
                    }
                  });
                  
                  if (newPasswordError == null) {
                      // Call your controller method
                      bool success = await controller.resetPassword();
                      if (success) {
                        // Show success dialog
                        _showSuccessDialog();
                      }
                  }
                },
              )),

              SizedBox(height: 12.h),

              /// CANCEL BUTTON
              AppButton(
                text: 'Cancel'.tr,
                textColor: const Color(0xFF060017),
                backgroundColor: Colors.white,
                withBorder: true,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Password Input Field Widget
class _PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final VoidCallback onToggleVisibility;

  const _PasswordInputField({
    required this.controller,
    required this.hintText,
    required this.isObscure,
    required this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, size: 20.sp, color: const Color(0xFF49494B)),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isObscure,
              style: TextStyle(
                color: const Color(0xFF49494B),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.56,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: const Color(0xFF49494B),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: onToggleVisibility,
            child: Icon(
              isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20.sp,
              color: const Color(0xFF49494B),
            ),
          ),
        ],
      ),
    );
  }
}