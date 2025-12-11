import 'package:get/get.dart';

import '../controllers/output_outfit_controller.dart';

class OutputOutfitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutputOutfitController>(
      () => OutputOutfitController(),
    );
  }
}
