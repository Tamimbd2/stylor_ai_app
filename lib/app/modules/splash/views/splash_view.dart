import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../onboarding/views/onboarding_view.dart';  // ← Add this import

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();

    // 🔥 3 sec delay then go to Onboarding screen
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => const OnboardingView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
