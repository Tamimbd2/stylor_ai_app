import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../service/apiservice.dart';
import '../../../controllers/user_controller.dart';

class EditProfileController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final UserController _userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
    // Fetch latest data from API
    _userController.fetchUser().then((_) {
      _loadUserProfile(); // Reload if updated
    });
  }

  void _loadUserProfile() {
    final user = _userController.user.value;
    if (user != null) {
      if (user.birthdate != null) {
        try {
          // Assuming format yyyy-MM-dd from API/User model
          selectedDate.value = DateTime.parse(user.birthdate!);
        } catch (_) {}
      }
      if (user.gender != null) selectedGender.value = user.gender!;
      if (user.country != null) selectedCountry.value = user.country!;
      
      final em = user.fashionPreferences;
      if (em != null) {
        if (em.season != null) selectedSeason.value = em.season!;
        if (em.style != null) selectedStyle.value = em.style!;
        if (em.preferencesColor != null) selectedColor.value = em.preferencesColor!;
        if (em.bodyType != null) selectedBodyType.value = em.bodyType!;
        if (em.skinTone != null) selectedSkinTone.value = em.skinTone!;
      }
    }
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

  // Season, Style, Color, BodyType, SkinTone
  final selectedSeason = ''.obs;
  final selectedStyle = ''.obs;
  final selectedColor = ''.obs;
  final selectedBodyType = ''.obs;
  final selectedSkinTone = ''.obs;
  
  // Setters
  void selectSeason(String v) => selectedSeason.value = v;
  void selectStyle(String v) => selectedStyle.value = v;
  void selectColor(String v) => selectedColor.value = v;
  void selectBodyType(String v) => selectedBodyType.value = v;
  void selectSkinTone(String v) => selectedSkinTone.value = v;

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
        'season': selectedSeason.value,
        'style': selectedStyle.value,
        'preferencesColor': selectedColor.value,
        'bodyType': selectedBodyType.value,
        'skinTone': selectedSkinTone.value,
      };

      final updatedUser = await _apiService.updateUserProfile(
        birthdate: birthDateStr,
        gender: selectedGender.value,
        country: selectedCountry.value,
        fashionPreferences: fashionPreferences,
      );

      if (updatedUser != null) {
        _userController.updateUser(updatedUser);
        Get.back();
        Get.snackbar('Success', 'Profile updated successfully!', 
          backgroundColor: Colors.black, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile', 
        backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isUploading.value = false;
    }
  }
}

