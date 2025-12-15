import 'package:get/get.dart';

class OutputOutfitController extends GetxController {
  //TODO: Implement OutputOutfitController

  final count = 0.obs;
  final selectedChip = 'All'.obs;
  final isFeaturedOutfitFavorited = false.obs;
  final favoriteProducts = <int>{}.obs;

  void toggleFeaturedFavorite() {
    isFeaturedOutfitFavorited.value = !isFeaturedOutfitFavorited.value;
  }

  void toggleProductFavorite(int index) {
    if (favoriteProducts.contains(index)) {
      favoriteProducts.remove(index);
    } else {
      favoriteProducts.add(index);
    }
  }

  void selectChip(String chipLabel) {
    selectedChip.value = chipLabel;
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
