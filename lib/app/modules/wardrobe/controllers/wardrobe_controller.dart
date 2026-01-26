import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../service/apiservice.dart';

class WardrobeController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  
  final selectedFilter = 'All'.obs;
  final isAnalyzing = false.obs;
  final isLoading = false.obs;
  final analyzingImage = Rx<File?>(null);
  final wardrobeItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWardrobeItems();
  }

  void selectFilter(String filterLabel) {
    selectedFilter.value = filterLabel;
  }

  // Get filtered items based on selected category
  List<Map<String, dynamic>> get filteredItems {
    if (selectedFilter.value == 'All') {
      return wardrobeItems;
    }
    
    // Special case: lowerwear filter also shows shoes
    if (selectedFilter.value.toLowerCase() == 'lowerwear') {
      return wardrobeItems.where((item) {
        final category = item['category'] as String? ?? '';
        return category.toLowerCase() == 'lowerwear' || category.toLowerCase() == 'shoe';
      }).toList();
    }
    
    return wardrobeItems.where((item) {
      final category = item['category'] as String? ?? '';
      return category.toLowerCase() == selectedFilter.value.toLowerCase();
    }).toList();
  }

  // Detect category from title
  String _detectCategory(String title) {
    final titleLower = title.toLowerCase();
    
    // Upperwear category keywords
    if (titleLower.contains('shirt') || 
        titleLower.contains('t-shirt') || 
        titleLower.contains('tshirt') ||
        titleLower.contains('blouse') || 
        titleLower.contains('top') || 
        titleLower.contains('jacket') || 
        titleLower.contains('coat') ||
        titleLower.contains('sweater') ||
        titleLower.contains('hoodie') ||
        titleLower.contains('dress')) {
      return 'upperwear';
    }
    
    // Lowerwear category keywords
    if (titleLower.contains('pant') || 
        titleLower.contains('trouser') || 
        titleLower.contains('jeans') || 
        titleLower.contains('short') || 
        titleLower.contains('skirt') ||
        titleLower.contains('underwear') ||
        titleLower.contains('legging')) {
      return 'lowerwear';
    }
    
    // Sunglass category keywords
    if (titleLower.contains('sunglass') || 
        titleLower.contains('glasses') || 
        titleLower.contains('eyewear')) {
      return 'Sunglass';
    }
    
    // Bag category keywords
    if (titleLower.contains('bag') || 
        titleLower.contains('purse') || 
        titleLower.contains('backpack') || 
        titleLower.contains('handbag')) {
      return 'Bag';
    }
    
    // Shoe category keywords
    if (titleLower.contains('shoe') || 
        titleLower.contains('sneaker') || 
        titleLower.contains('boot') || 
        titleLower.contains('sandal') ||
        titleLower.contains('heel') ||
        titleLower.contains('slipper') ||
        titleLower.contains('loafer') ||
        titleLower.contains('footwear')) {
      return 'Shoe';
    }
    
    // Default to upperwear if no match
    return 'upperwear';
  }

  // Fetch wardrobe items from API
  Future<void> fetchWardrobeItems() async {
    try {
      isLoading.value = true;
      final items = await _apiService.getWardrobe();
      
      if (items != null) {
        wardrobeItems.clear();
        wardrobeItems.addAll(items.map((item) {
          final title = item['title'] ?? 'Wardrobe Item';
          return {
            'id': item['id'],
            'image': item['image_url'] ?? item['image_path'],
            'title': title,
            'category': _detectCategory(title),
            'created_at': item['created_at'],
            'fit': BoxFit.cover,
            'isAsset': false,
          };
        }).toList());
        print('Loaded ${wardrobeItems.length} wardrobe items');
      }
    } catch (e) {
      print('Error fetching wardrobe items: $e');
      Get.snackbar(
        'Error',
        'Failed to load wardrobe items',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh wardrobe items
  Future<void> refreshWardrobe() async {
    await fetchWardrobeItems();
  }

  Future<void> startAnalyzing(File capturedPhoto) async {
    analyzingImage.value = capturedPhoto;
    isAnalyzing.value = true;
    
    try {
      final response = await _apiService.generateFlatLay(capturedPhoto);
      
      if (response != null && response['success'] == true) {
         print('Flat Lay Response: $response');
         
         // Refresh wardrobe to get the newly added item
         await fetchWardrobeItems();
         
         Get.snackbar(
           'Success', 
           'Item added to wardrobe!',
           backgroundColor: Colors.black,
           colorText: Colors.white,
           snackPosition: SnackPosition.BOTTOM,
         );
      } else {
         Get.snackbar(
           'Error', 
           'Failed to analyze image',
           backgroundColor: Colors.red,
           colorText: Colors.white,
           snackPosition: SnackPosition.BOTTOM,
         );
      }
    } catch (e) {
      print('Analysis error: $e');
      Get.snackbar(
        'Error', 
        'An error occurred during analysis',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAnalyzing.value = false;
      analyzingImage.value = null;
    }
  }
}
