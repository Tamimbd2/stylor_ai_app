import 'package:get/get.dart';

class ShapeselectController extends GetxController {
  //TODO: Implement ShapeselectController

  final count = 0.obs;
  final showOutfitDetails = false.obs;

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

  void toggleOutfitDetails() => showOutfitDetails.toggle();
}
