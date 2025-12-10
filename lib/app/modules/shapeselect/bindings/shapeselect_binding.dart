import 'package:get/get.dart';

import '../controllers/shapeselect_controller.dart';

class ShapeselectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShapeselectController>(
      () => ShapeselectController(),
    );
  }
}
