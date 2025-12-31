import 'package:get/get.dart';
import '../../../controllers/user_controller.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (Get.find<UserController>().isLoggedIn) {
        Get.offNamed(Routes.SHAPESELECT);
      } else {
        Get.offNamed(Routes.ONBOARDING);
      }
    });
  }
}
