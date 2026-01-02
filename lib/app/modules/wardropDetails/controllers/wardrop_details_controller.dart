import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WardropDetailsController extends GetxController {
  final count = 0.obs;

  /// Selected color / image index
  final selectedColorIndex = 0.obs;

  /// PageController for swipe (PageView)
  late final PageController pageController;

  /// Color variants (image + color)
  final colorVariants = <Map<String, dynamic>>[
    {
      'color': 0xFF060017,
      'image': 'assets/image/clothes.png',
      'isAsset': true,
    },
    {
      'color': 0xFFF4F4F4,
      'image': 'assets/image/dress2.png',
      'isAsset': true,
    },
  ].obs;

  /// Called when color dot is tapped
  void selectColor(int index) {
    if (index < colorVariants.length) {
      selectedColorIndex.value = index;

      /// Sync PageView
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Called when user swipes image
  void onPageChanged(int index) {
    if (index < colorVariants.length) {
      selectedColorIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedColorIndex.value);

    // Initial setup from arguments if available
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      colorVariants.clear();
      
      // Add the main image (likely generated flat lay or asset)
      colorVariants.add({
        'color': 0xFF000000, 
        'image': args['image'] ?? '',
        'isAsset': args['isAsset'] ?? true,
      });

      // If there is an original captured image, add it as the second option (swipe right)
      if (args['originalImage'] != null) {
        colorVariants.add({
          'color': 0xFFCCCCCC,
          'image': args['originalImage'],
          'isAsset': false, // Captured photos are files
        });
      }
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Optional counter
  void increment() => count.value++;
}
