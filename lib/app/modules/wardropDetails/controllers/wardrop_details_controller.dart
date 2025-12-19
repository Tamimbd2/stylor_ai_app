import 'package:get/get.dart';

class WardropDetailsController extends GetxController {
  final count = 0.obs;
  final selectedColorIndex = 0.obs;

  // Color variants - you can customize these
  final colorVariants = <Map<String, dynamic>>[
    {'color': 0xFF060017, 'image': 'assets/image/clothes.png'},
    {'color': 0xFFF4F4F4, 'image': 'assets/image/dress2.png'},
  ].obs;

  void selectColor(int index) {
    if (index < colorVariants.length) {
      selectedColorIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
