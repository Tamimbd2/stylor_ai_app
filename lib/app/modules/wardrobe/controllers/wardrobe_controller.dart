import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../service/apiservice.dart';

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

  Future<void> startAnalyzing(File capturedPhoto) async {
    analyzingImage.value = capturedPhoto;
    isAnalyzing.value = true;
    
    try {
      final apiService = Get.put(ApiService());
      final response = await apiService.generateFlatLay(capturedPhoto);
      
      if (response != null && response['success'] == true && response['imageUrl'] != null) {
         final imgData = response['imageUrl'];
         final String remoteUrl = imgData['imageUrl'];
         final String title = imgData['title'] ?? 'New Item';
         
         print('Generated Flat Lay URL: $remoteUrl');

         // Add to wardrobe
         wardrobeItems.insert(0, {
            'image': remoteUrl,
            'fit': BoxFit.cover,
            'isAsset': false,
            'title': title,
            'originalImage': capturedPhoto.path  // Store the original captured photo path
         });
         Get.snackbar('Success', 'Item added to wardrobe!');
      } else {
         Get.snackbar('Error', 'Failed to analyze image');
      }
    } catch (e) {
      print('Analysis error: $e');
      Get.snackbar('Error', 'An error occurred during analysis: $e');
    } finally {
      isAnalyzing.value = false;
      analyzingImage.value = null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }




  void increment() => count.value++;
}
