import 'package:get/get.dart';

class SplashController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    navigateToNext();
  }

  void navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/onboarding');
    });
  }
}
