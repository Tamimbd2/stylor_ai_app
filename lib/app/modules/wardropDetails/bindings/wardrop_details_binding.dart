import 'package:get/get.dart';

import '../controllers/wardrop_details_controller.dart';

class WardropDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WardropDetailsController>(
      () => WardropDetailsController(),
    );
  }
}
