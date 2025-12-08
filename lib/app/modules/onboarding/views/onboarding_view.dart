import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),

              /// LOGO
              Center(
                child: Image.asset(
                  'assets/logo/logo.png',
                  height: 50,
                ),
              ),

              const SizedBox(height: 10),

              /// -------------------------------
              ///  BIG FULL IMAGE (NO CARD)
              /// -------------------------------
              SizedBox(
                height: 450,
                width: double.infinity,
                child: Image.asset(
                  'assets/image/onboarding.png',

                ),
              ),

              const Text(
                'Your AI outfit, instantly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Personalized fashion advice, AI-powered outfit\nrecommendations, all in one app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 28),

              /// GET STARTED BUTTON
            AppButton(
              text: "Get Started",
              textColor: AppColors.primaryLight,
              backgroundColor: AppColors.primaryDark,
              onPressed: () {},

            ),

              const SizedBox(height: 12),
              /// LOGIN BUTTON
            AppButton(
              text: "Login",
              textColor: Colors.black,
              backgroundColor: AppColors.primaryLight,
              onPressed: () {},
              withBorder: true,

            ),


            const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
