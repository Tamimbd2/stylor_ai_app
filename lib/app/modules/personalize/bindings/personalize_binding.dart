import 'package:get/get.dart';

import '../controllers/personalize_controller.dart';

class PersonalizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalizeController>(
      () => PersonalizeController(),
    );
  }
}
