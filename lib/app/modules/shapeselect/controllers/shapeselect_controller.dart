import 'package:get/get.dart';

class ShapeselectController extends GetxController {
  //TODO: Implement ShapeselectController

  final count = 0.obs;
  final showOutfitDetails = false.obs;




  void increment() => count.value++;

  void toggleOutfitDetails() => showOutfitDetails.toggle();
}
