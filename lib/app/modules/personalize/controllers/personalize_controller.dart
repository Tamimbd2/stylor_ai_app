import 'package:get/get.dart';

class PersonalizeController extends GetxController {
  // Date picker
  final selectedDate = Rx<DateTime?>(null);

  // Gender selection
  final selectedGender = Rx<String?>(null);

  // Country selection
  final selectedCountry = Rx<String?>(null);

  // Season selection
  final selectedSeason = Rx<String?>(null);

  // Style selection
  final selectedStyle = Rx<String?>(null);

  // Color preference selection
  final selectedColor = Rx<String?>(null);

  // Body type selection
  final selectedBodyType = Rx<String?>(null);

  // Skin tone selection
  final selectedSkinTone = Rx<String?>(null);

  // List of countries
  final countries = <String>[
    'Belgium',
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Argentina',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Brazil',
    'Canada',
    'China',
    'France',
    'Germany',
    'India',
    'Japan',
    'United Kingdom',
    'United States',
    'Bangladesh',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Set default date
    selectedDate.value = DateTime(2000, 4, 22);
    selectedGender.value = 'Male';
    selectedCountry.value = 'Belgium';
    selectedSeason.value = 'Spring';
    selectedStyle.value = 'Casual';
    selectedColor.value = 'Neutrals';
    selectedBodyType.value = 'Athletic';
    selectedSkinTone.value = 'Medium';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Format date to display
  String getFormattedDate() {
    if (selectedDate.value == null) return 'Select Date';
    final date = selectedDate.value!;
    return '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}';
  }

  // Get country flag emoji
  String getCountryFlag(String country) {
    const countryFlags = {
      'Belgium': '🇧🇪',
      'Afghanistan': '🇦🇫',
      'Albania': '🇦🇱',
      'Algeria': '🇩🇿',
      'Andorra': '🇦🇩',
      'Angola': '🇦🇴',
      'Argentina': '🇦🇷',
      'Australia': '🇦🇺',
      'Austria': '🇦🇹',
      'Azerbaijan': '🇦🇿',
      'Bahamas': '🇧🇸',
      'Bahrain': '🇧🇭',
      'Bangladesh': '🇧🇩',
      'Barbados': '🇧🇧',
      'Belarus': '🇧🇾',
      'Brazil': '🇧🇷',
      'Canada': '🇨🇦',
      'China': '🇨🇳',
      'France': '🇫🇷',
      'Germany': '🇩🇪',
      'India': '🇮🇳',
      'Japan': '🇯🇵',
      'United Kingdom': '🇬🇧',
      'United States': '🇺🇸',
    };
    return countryFlags[country] ?? '🌍';
  }
}
