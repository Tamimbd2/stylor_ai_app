import 'package:get/get.dart';

import '../controllers/take_photo_controller.dart';

class TakePhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TakePhotoController>(
      () => TakePhotoController(),
    );
  }
}
