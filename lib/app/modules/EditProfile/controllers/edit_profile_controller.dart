import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../service/apiservice.dart';
import '../../../controllers/user_controller.dart';

class EditProfileController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final UserController _userController = Get.find<UserController>();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch latest data from API first, then load profile
    _fetchAndLoadProfile();
  }

  Future<void> _fetchAndLoadProfile() async {
    try {
      isLoading.value = true;
      // Fetch latest user data from API
      await _userController.fetchUser();
      // Load profile after fetch completes
      _loadUserProfile();
    } catch (e) {
      print('Error fetching user profile: $e');
      // Still try to load from local storage
      _loadUserProfile();
    } finally {
      isLoading.value = false;
    }
  }

  void _loadUserProfile() {
    final user = _userController.user.value;
    if (user == null) {
      print('No user data found');
      return;
    }

    print('Loading user profile: ${user.name}');
    
    // Load birthdate
    if (user.birthdate != null && user.birthdate!.isNotEmpty) {
      try {
        // Handle both formats: yyyy-MM-dd and ISO 8601
        selectedDate.value = DateTime.parse(user.birthdate!);
      } catch (e) {
        print('Error parsing birthdate: $e');
        selectedDate.value = DateTime(2000, 1, 1);
      }
    } else {
      selectedDate.value = DateTime(2000, 1, 1);
    }
    
    // Load gender
    if (user.gender != null && user.gender!.isNotEmpty) {
      selectedGender.value = user.gender!;
    } else {
      selectedGender.value = 'Male';
    }
    
    // Load country with validation
    if (user.country != null && user.country!.isNotEmpty) {
      if (countries.contains(user.country!)) {
        selectedCountry.value = user.country!;
      } else {
        print('Warning: User country "${user.country}" not in predefined list, defaulting to Belgium');
        selectedCountry.value = 'Belgium';
      }
    } else {
      selectedCountry.value = 'Belgium';
    }
    
    // Load fashion preferences
    final prefs = user.fashionPreferences;
    if (prefs != null) {
      // Load season (can be String or List)
      if (prefs.season != null) {
        selectedSeason.clear();
        if (prefs.season is List) {
          selectedSeason.addAll((prefs.season as List).map((e) => e.toString()));
        } else {
          selectedSeason.add(prefs.season.toString());
        }
      }
      
      // Load style (can be String or List)
      if (prefs.style != null) {
        selectedStyle.clear();
        if (prefs.style is List) {
          selectedStyle.addAll((prefs.style as List).map((e) => e.toString()));
        } else {
          selectedStyle.add(prefs.style.toString());
        }
      }
      
      // Load color preferences (can be String or List)
      if (prefs.preferencesColor != null) {
        selectedColor.clear();
        if (prefs.preferencesColor is List) {
          selectedColor.addAll((prefs.preferencesColor as List).map((e) => e.toString()));
        } else {
          selectedColor.add(prefs.preferencesColor.toString());
        }
      }

      // Load body type
      if (prefs.bodyType != null && prefs.bodyType!.isNotEmpty) {
        selectedBodyType.value = prefs.bodyType!;
      }
      
      // Load skin tone
      if (prefs.skinTone != null && prefs.skinTone!.isNotEmpty) {
        selectedSkinTone.value = prefs.skinTone!;
      }

      // Load specific color
      if (prefs.color != null && prefs.color!.isNotEmpty) {
        selectedSpecificColor.value = prefs.color!;
      }
    }
    
    print('Profile loaded successfully');
    print('Season: ${selectedSeason.toList()}');
    print('Style: ${selectedStyle.toList()}');
    print('Color: ${selectedColor.toList()}');
  }

  // Profile Image
  final selectedImage = Rx<File?>(null);
  final isUploading = false.obs;

  // Date
  final selectedDate = DateTime.now().obs;

  // Gender
  final selectedGender = 'Male'.obs;

  // Country
  final selectedCountry = 'Belgium'.obs;

  // Season, Style, Color (Multi)
  final selectedSeason = <String>[].obs;
  final selectedStyle = <String>[].obs;
  final selectedColor = <String>[].obs;

  final selectedBodyType = ''.obs;
  final selectedSkinTone = ''.obs;
  final selectedSpecificColor = ''.obs;

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
  
  // Setters
  // Setters
  void toggleSeason(String v) {
    if (selectedSeason.contains(v)) {
      selectedSeason.remove(v);
    } else {
      selectedSeason.add(v);
    }
  }

  void toggleStyle(String v) {
    selectedStyle.clear();
    selectedStyle.add(v);
  }

  void toggleColor(String v) {
    if (selectedColor.contains(v)) {
      selectedColor.remove(v);
    } else {
      selectedColor.add(v);
    }
  }
  void selectBodyType(String v) => selectedBodyType.value = v;
  void selectSkinTone(String v) => selectedSkinTone.value = v;
  void selectSpecificColor(String v) => selectedSpecificColor.value = v;

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

  String getFormattedDate() {
    return DateFormat('dd / MM / yyyy').format(selectedDate.value);
  }

  // Pick Image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      // Automatically upload when picked? Or wait for save?
      // User request implies "profile photo update kora jabe" -> usually implies immediate or on save.
      // Let's do it immediately for better UX feedback or on separate button? 
      // The current UI has a camera icon on the profile picture.
      // Let's upload immediately as it is a common pattern for profile pictures, 
      // OR specifically on a "Check" button.
      // Given the UI structure, uploading immediately after pick is easiest to ensure "full app" sync instantly.
      
      await uploadProfileImage();
    }
  }

  // Upload Image
  Future<void> uploadProfileImage() async {
    if (selectedImage.value == null) return;
    
    try {
      isUploading.value = true;
      Get.snackbar('Uploading', 'Updating profile picture...', 
        backgroundColor: Colors.black, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      
      final newUrl = await _apiService.uploadAvatar(selectedImage.value!);
      
      if (newUrl != null) {
        _userController.updateAvatar(newUrl);
        Get.snackbar('Success', 'Profile picture updated!', 
          backgroundColor: Colors.black, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image', 
        backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUploading.value = false;
    }
  }
  Future<void> saveProfile() async {
    try {
      isUploading.value = true;
      Get.snackbar('Saving', 'Updating profile...', 
        backgroundColor: Colors.black, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);

      String birthDateStr = DateFormat('yyyy-MM-dd').format(selectedDate.value);
      
      final fashionPreferences = {
        'season': selectedSeason.toList(),
        'style': selectedStyle.toList(),
        'preferencesColor': selectedColor.toList(),
        'bodyType': selectedBodyType.value,
        'skinTone': selectedSkinTone.value,
        'color': selectedSpecificColor.value,
      };

      print('===== Saving Profile =====');
      print('Birthdate: $birthDateStr');
      print('Gender: ${selectedGender.value}');
      print('Country: ${selectedCountry.value}');
      print('Fashion Preferences: $fashionPreferences');
      print('=========================');

      final updatedUser = await _apiService.updateUserProfile(
        birthdate: birthDateStr,
        gender: selectedGender.value,
        country: selectedCountry.value,
        fashionPreferences: fashionPreferences,
      );

      if (updatedUser != null) {
        await _userController.updateUser(updatedUser);
        Get.back();
        Get.snackbar('Success', 'Profile updated successfully!', 
          backgroundColor: Colors.black, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'No response from server', 
          backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('Error saving profile: $e');
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}', 
        backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUploading.value = false;
    }
  }
}

