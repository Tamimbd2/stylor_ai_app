import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  var currentPage = 0.obs;

  final onboardingPages = [
    {
      'title': 'Welcome to Outfit',
      'description': 'Discover amazing fashion and style tips',
      'icon': Icons.shopping_bag,
    },
    {
      'title': 'Easy Shopping',
      'description': 'Browse and shop from your favorite brands',
      'icon': Icons.store,
    },
    {
      'title': 'Track Orders',
      'description': 'Keep track of your orders in real time',
      'icon': Icons.local_shipping,
    },
    {
      'title': 'Get Started',
      'description': 'Start your fashion journey today',
      'icon': Icons.favorite,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void nextPage() {
    if (currentPage.value == onboardingPages.length - 1) {
      Get.offNamed('/login');
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
