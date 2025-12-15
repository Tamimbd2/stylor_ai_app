import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  // Single selection for each category
  final selectedSeason = Rx<String>('');
  final selectedStyle = Rx<String>('');
  final selectedColor = Rx<String>('');
  final selectedBodyType = Rx<String>('');
  final selectedSkinTone = Rx<String>('');

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

  // Single selection for seasons
  void selectSeason(String season) {
    selectedSeason.value = season;
  }

  // Single selection for styles
  void selectStyle(String style) {
    selectedStyle.value = style;
  }

  // Single selection for colors
  void selectColor(String color) {
    selectedColor.value = color;
  }

  // Single selection for body types
  void selectBodyType(String bodyType) {
    selectedBodyType.value = bodyType;
  }

  // Single selection for skin tones
  void selectSkinTone(String skinTone) {
    selectedSkinTone.value = skinTone;
  }
}
