import 'package:get/get.dart';
import '../../../controllers/user_controller.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    final userController = Get.find<UserController>();
    
    // Wait for UserController to initialize (load from secure storage)
    while (!userController.isInitialized.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    // Wait minimum 3 seconds for splash animation
    await Future.delayed(const Duration(seconds: 3));
    
    // Check if user is logged in
    if (userController.isLoggedIn) {
      print('Auto-login: User is logged in, navigating to Home with Bottom Nav');
      Get.offNamed(Routes.HOME);
    } else {
      print('No token found, navigating to Onboarding');
      Get.offNamed(Routes.ONBOARDING);
    }
  }
}

