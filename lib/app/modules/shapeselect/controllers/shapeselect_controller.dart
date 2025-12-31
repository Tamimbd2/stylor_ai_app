import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service/apiservice.dart';

class ShapeselectController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  
  final isLoading = false.obs;
  final generatedImages = <String>[].obs;
  final selectedStyle = 'Casual'.obs; // Default option
  final temperature = 0.8.obs; // Default temperature

  final showOutfitDetails = false.obs;

  @override
  void onInit() {
    super.onInit();
    generateOutfit();
  }

  void updateStyle(String style) {
    selectedStyle.value = style;
    generateOutfit();
  }

  void updateTemperature(double temp) {
    temperature.value = temp;
    generateOutfit();
  }

  Future<void> generateOutfit() async {
    try {
      isLoading.value = true;
      generatedImages.clear(); 

      // Create 5 future tasks
      final displayFutures = List.generate(5, (_) => _apiService.generateFashion(
        option: selectedStyle.value,
        temperature: temperature.value,
      ));

      final results = await Future.wait(displayFutures);
      
      print('Full Response Count: ${results.length}');

      for (var result in results) {
         if (result != null) {
          String? url;
          if (result['generatedImage'] != null && result['generatedImage'] is Map) {
             url = result['generatedImage']['url'];
          } else if (result['imageUrl'] != null) {
             url = result['imageUrl']; 
          }

          if (url != null) {
            // Quick fix for localhost/emulator
            if (url.startsWith('http://localhost') && GetPlatform.isAndroid) {
              url = url.replaceFirst('http://localhost', 'http://10.0.2.2');
            }
            generatedImages.add(url);
          }
         }
      }

    } catch (e) {
       print("Error generating outfit: $e");
       Get.snackbar(
        'Error',
        'Failed to generate outfit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleOutfitDetails() => showOutfitDetails.toggle();
}
