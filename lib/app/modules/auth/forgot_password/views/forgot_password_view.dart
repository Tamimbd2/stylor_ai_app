import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widgets/primary_button.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({super.key});
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );
  String? errorText;
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

              /// LOGO
              Center(child: Image.asset('assets/logo/logo.png', height: 50.h)),

              SizedBox(height: 40.h),

              /// TITLE
              Text(
                'Forget Password',
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

              /// SUBTITLE
              Text(
                'Enter your email account to reset password',
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

              /// EMAIL INPUT
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: TextStyle(
                      color: const Color(0xFF1C1C1E),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.56,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFE8E8E8),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 20.sp,
                          color: const Color(0xFF49494B),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            controller: controller.emailController,
                            style: TextStyle(
                              color: const Color(0xFF49494B),
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.56,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (errorText != null)
                    Padding(
                      padding: EdgeInsets.only(top: 6.h, left: 4.w),
                      child: Text(
                        errorText!,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 280.h),

              /// CONTINUE BUTTON
              AppButton(
                text: "Continue",
                textColor: Colors.white,
                backgroundColor: const Color(0xFF060017),
                onPressed: () {
                  setState(() {
                    if (controller.emailController.text.isEmpty) {
                      errorText = 'Please enter your email address';
                    } else {
                      errorText = null;
                      controller.sendOtp();
                      Navigator.pushNamed(context, '/otp');
                    }
                  });
                },
              ),

              SizedBox(height: 12.h),

              /// CANCEL BUTTON
              AppButton(
                text: "Cancel",
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
