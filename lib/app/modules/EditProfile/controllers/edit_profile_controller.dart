import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController {
  // Date
  final selectedDate = DateTime.now().obs;

  // Gender
  final selectedGender = 'Male'.obs;

  // Country
  final selectedCountry = 'Belgium'.obs;

  // Season
  final selectedSeason = ''.obs;
  void selectSeason(String season) => selectedSeason.value = season;

  // Style
  final selectedStyle = ''.obs;
  void selectStyle(String style) => selectedStyle.value = style;

  // Color Preferences
  final selectedColor = ''.obs;
  void selectColor(String color) => selectedColor.value = color;

  // Body Type
  final selectedBodyType = ''.obs;
  void selectBodyType(String bodyType) => selectedBodyType.value = bodyType;

  // Skin Tone
  final selectedSkinTone = ''.obs;
  void selectSkinTone(String skinTone) => selectedSkinTone.value = skinTone;

  // Get formatted date
  String getFormattedDate() {
    return DateFormat('dd / MM / yyyy').format(selectedDate.value);
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
}
