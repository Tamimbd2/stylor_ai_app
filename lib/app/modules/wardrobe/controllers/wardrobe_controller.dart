import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WardrobeController extends GetxController {
  //TODO: Implement WardrobeController

  final count = 0.obs;
  final selectedFilter = 'All'.obs;
  final isAnalyzing = false.obs;
  final analyzingImage = Rx<File?>(null);
  final wardrobeItems = <Map<String, dynamic>>[
    {'image': 'assets/image/clothes.png', 'fit': BoxFit.cover, 'isAsset': true},
    {'image': 'assets/image/dress2.png', 'fit': BoxFit.cover, 'isAsset': true},
    {'image': 'assets/image/shoe.png', 'fit': BoxFit.contain, 'isAsset': true},
    {'image': 'assets/image/dreess1.png', 'fit': BoxFit.cover, 'isAsset': true},
    {'image': 'assets/image/sunglass.png', 'fit': BoxFit.contain, 'isAsset': true},
  ].obs;

  void selectFilter(String filterLabel) {
    selectedFilter.value = filterLabel;
  }

  void startAnalyzing(File capturedPhoto) {
    analyzingImage.value = capturedPhoto;
    isAnalyzing.value = true;
    
    // Simulate AI analysis for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      isAnalyzing.value = false;
      // Add the new photo to wardrobe
      wardrobeItems.insert(0, {
        'image': capturedPhoto.path,
        'fit': BoxFit.cover,
        'isAsset': false,
      });
      analyzingImage.value = null;
    });
  }

  @override
  void onInit() {
    super.onInit();
  }




  void increment() => count.value++;
}
