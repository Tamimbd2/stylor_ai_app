import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  
  // Observable for selected language code (default 'en')
  var selectedLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with current locale
    if(Get.locale != null){
      selectedLanguage.value = Get.locale!.languageCode;
    }
  }

  void updateLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
    selectedLanguage.value = languageCode;
  }
}

