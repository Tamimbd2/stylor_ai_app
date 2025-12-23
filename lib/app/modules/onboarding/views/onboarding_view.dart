import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:outfit/core/color.dart';
import '../../../../widgets/primary_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),

              /// LOGO
              Center(child: Image.asset('assets/logo/logo.png', height: 50.h)),

              SizedBox(height: 40.h),

              /// -------------------------------
              ///  BIG FULL IMAGE (NO CARD)
              /// -------------------------------
              // SizedBox(
              //   height: 350.h,
              //   width: double.infinity,
              //   child: SvgPicture.asset(
              //     'assets/svg/group.svg',
              //     fit: BoxFit.contain,
              //   ),
              // ),

              // SizedBox(
              //   height: 400.h,
              //   width: double.infinity,
              //   child: Image.asset('assets/image/test.png'), ),
              Expanded(
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Image.asset(
                        'assets/image/test.png',
                        height: 500,
                        fit: BoxFit.contain,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: Column(
                        children: [
                          const Spacer(), //

                          Text(
                            'Your AI outfit, instantly.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Text(
                            'Personalized fashion advice, AI-powered outfit\nrecommendations, all in one app.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 24.h),

                          AppButton(
                            text: "Get Started",
                            textColor: AppColors.primaryLight,
                            backgroundColor: AppColors.primaryDark,
                            onPressed: () {
                              Get.toNamed('/signup');
                            },
                          ),
                          SizedBox(height: 12.h),

                          AppButton(
                            text: "Login",
                            textColor: Colors.black,
                            backgroundColor: AppColors.primaryLight,
                            withBorder: true,
                            onPressed: () {
                              Get.toNamed('/auth-login');
                            },
                          ),

                          SizedBox(height: 24.h), // bottom padding
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
