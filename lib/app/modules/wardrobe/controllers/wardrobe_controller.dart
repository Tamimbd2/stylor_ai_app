import 'package:get/get.dart';

class WardrobeController extends GetxController {
  //TODO: Implement WardrobeController

  final count = 0.obs;
  final selectedFilter = 'All'.obs;

  void selectFilter(String filterLabel) {
    selectedFilter.value = filterLabel;
  }




  void increment() => count.value++;
}
