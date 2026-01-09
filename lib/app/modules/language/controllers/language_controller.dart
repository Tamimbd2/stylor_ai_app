import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();
  
  // Observable for selected language code (default 'en')
  var selectedLanguage = 'en'.obs;
  var selectedLanguageName = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved language from storage
    selectedLanguage.value = _storage.read('language_code') ?? 'en';
    selectedLanguageName.value = _storage.read('language_name') ?? 'English';
    
    // Initialize with current locale
    if(Get.locale != null){
      selectedLanguage.value = Get.locale!.languageCode;
      selectedLanguageName.value = _getLanguageName(Get.locale!.languageCode);
    }
  }

  void updateLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
    selectedLanguage.value = languageCode;
    
    // Get language name and save
    final languageName = _getLanguageName(languageCode);
    selectedLanguageName.value = languageName;
    
    // Save to storage
    _storage.write('language_code', languageCode);
    _storage.write('language_name', languageName);
    
    print('Language updated: $languageName ($languageCode)');
  }
  
  // Get language display name from code
  String _getLanguageName(String code) {
    switch(code) {
      case 'en':
        return 'English';
      case 'nl':
        return 'Dutch';
      case 'fr':
        return 'French';
      default:
        return 'English';
    }
  }
  
  // Public getter for current language name
  String get currentLanguageName => selectedLanguageName.value;
}
