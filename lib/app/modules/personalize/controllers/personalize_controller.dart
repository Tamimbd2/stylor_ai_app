import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../service/apiservice.dart';
import '../../filterScreen/views/filter_screen_view.dart';

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
    'United Kingdom',
    'Austria',
    'Belgium',
    'Bulgaria',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Estonia',
    'Finland',
    'France',
    'Germany',
    'Greece',
    'Hungary',
    'Ireland',
    'Italy',
    'Latvia',
    'Lithuania',
    'Luxembourg',
    'Malta',
    'Netherlands',
    'Poland',
    'Portugal',
    'Romania',
    'Slovakia',
    'Slovenia',
    'Spain',
    'Sweden',


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



  // Loading state
  final isLoading = false.obs;

  // Format date to display
  String getFormattedDate() {
    if (selectedDate.value == null) return 'Select Date';
    final date = selectedDate.value!;
    return '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}';
  }

  // Get country flag emoji
  String getCountryFlag(String country) {
    const countryFlags = {
      'United Kingdom': '🇬🇧',
      'Austria': '🇦🇹',
      'Belgium': '🇧🇪',
      'Bulgaria': '🇧🇬',
      'Croatia': '🇭🇷',
      'Cyprus': '🇨🇾',
      'Czech Republic': '🇨🇿',
      'Denmark': '🇩🇰',
      'Estonia': '🇪🇪',
      'Finland': '🇫🇮',
      'France': '🇫🇷',
      'Germany': '🇩🇪',
      'Greece': '🇬🇷',
      'Hungary': '🇭🇺',
      'Ireland': '🇮🇪',
      'Italy': '🇮🇹',
      'Latvia': '🇱🇻',
      'Lithuania': '🇱🇹',
      'Luxembourg': '🇱🇺',
      'Malta': '🇲🇹',
      'Netherlands': '🇳🇱',
      'Poland': '🇵🇱',
      'Portugal': '🇵🇹',
      'Romania': '🇷🇴',
      'Slovakia': '🇸🇰',
      'Slovenia': '🇸🇮',
      'Spain': '🇪🇸',
      'Sweden': '🇸🇪',

    };
    return countryFlags[country] ?? '🌍';
  }

  Future<void> updateProfile() async {
    if (selectedDate.value == null) return;
    
    try {
      isLoading.value = true;
      String birthdate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
      
      final apiService = Get.put(ApiService());
      
      print("Updating Profile Basic Info:");
      print("Birthdate: $birthdate");
      print("Gender: ${selectedGender.value}");
      print("Country: ${selectedCountry.value}");

      // Call API with just basic info
      await apiService.updateUserProfile(
        birthdate: birthdate,
        gender: selectedGender.value ?? 'Male',
        country: selectedCountry.value ?? 'Belgium',
        // No fashion preferences here
      );

      // Navigate to Filter Screen on success
      Get.to(
        () => FilterScreenView(), 
        arguments: {
          'birthdate': birthdate,
          'gender': selectedGender.value,
          'country': selectedCountry.value,
        }
      );
      
      Get.snackbar(
        'Success', 
        'Profile updated! Now select your preferences.',
        backgroundColor: Colors.black, 
        colorText: Colors.white, 
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
      );

    } catch (e) {
      Get.snackbar(
        'Error', 
        e.toString(),
        backgroundColor: Colors.red, // Colors.red
        colorText: Colors.white, // Colors.white
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
