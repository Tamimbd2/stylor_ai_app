import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service/apiservice.dart';
import '../../../routes/app_pages.dart'; // Assuming routes are here for Get.offAllNamed if needed, or just use string

import '../../output_outfit/views/main_navigation_view.dart';

class FilterScreenController extends GetxController {
  // Multi-selection for categories
  final selectedSeason = <String>[].obs;
  final selectedStyle = <String>[].obs;
  final selectedColor = <String>[].obs;
  
  // Single selection
  final selectedBodyType = Rx<String>('');
  final selectedSkinTone = Rx<String>('');
  final selectedSpecificColor = Rx<String>('');

  // Arguments from previous screen
  String? birthdate;
  String? gender;
  String? country;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      birthdate = args['birthdate'];
      gender = args['gender'];
      country = args['country'];
      print("Received basics: $birthdate, $gender, $country");
    }
  }

  // Toggle selection for seasons
  void toggleSeason(String season) {
    if (selectedSeason.contains(season)) {
      selectedSeason.remove(season);
    } else {
      selectedSeason.add(season);
    }
  }

  // Toggle selection for styles
  void toggleStyle(String style) {
     if (selectedStyle.contains(style)) {
      selectedStyle.remove(style);
    } else {
      selectedStyle.add(style);
    }
  }

  // Toggle selection for colors
  void toggleColor(String color) {
    if (selectedColor.contains(color)) {
      selectedColor.remove(color);
    } else {
      selectedColor.add(color);
    }
  }

  // Single selection for body types
  void selectBodyType(String bodyType) {
    selectedBodyType.value = bodyType;
  }

  // Single selection for skin tones
  void selectSkinTone(String skinTone) {
    selectedSkinTone.value = skinTone;
  }

  // Single selection for specific color
  void selectSpecificColor(String color) {
    selectedSpecificColor.value = color;
  }

  Future<void> submitPreferences() async {
    print("Submit button clicked");

    if (birthdate == null || gender == null || country == null) {
      Get.snackbar(
        "Error", 
        "Missing user profile data. Please start from the beginning.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error: Missing basics: $birthdate, $gender, $country");
      return;
    }

    final fashionPreferences = {
      "season": selectedSeason.toList(),
      "style": selectedStyle.toList(),
      "preferencesColor": selectedColor.toList(),
      "bodyType": selectedBodyType.value,
      "skinTone": selectedSkinTone.value,
      "color": selectedSpecificColor.value,
    };

    print("Submitting full profile update...");
    print("Basics: $birthdate, $gender, $country");
    print("Preferences: $fashionPreferences");

    try {
      isLoading.value = true;
      final apiService = Get.put(ApiService()); // Ensure service is available
      
      await apiService.updateUserProfile(
        birthdate: birthdate!,
        gender: gender!,
        country: country!,
        fashionPreferences: fashionPreferences,
      );
      
      Get.snackbar(
        "Success", 
        "Profile Setup Complete!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

       // Get.offAllNamed('/main-navigation');
       Get.offAll(() => MainNavigationView());

    } catch (e) {
      print("API Error: $e");
      Get.snackbar(
        "Error", 
        "Failed to update preferences: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
