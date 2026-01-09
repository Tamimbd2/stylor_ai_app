import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import '../../../controllers/user_controller.dart';
import '../../../routes/app_pages.dart';


class ProfileController extends GetxController {
  final UserController _userController = Get.find<UserController>();
  
  final isNotificationEnabled = true.obs;

  void toggleNotification(bool value) {
    isNotificationEnabled.value = value;
  }

  // Share app functionality
  void shareApp() {
    final String message = '''
🌟 Check out Stylor AI - Your AI Fashion Assistant! 🌟

Get personalized outfit recommendations powered by AI.
Download now and transform your wardrobe!

📱 Download: https://play.google.com/store/apps/details?id=com.example.outfit
    ''';
    
    Share.share(
      message,
      subject: 'Stylor AI - AI Fashion Assistant',
    );
  }

  // Logout functionality with confirmation dialog
  void logout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
            },
            child: const Text(
              'No',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.back(); // Close dialog first
              
              // Show loading
              Get.dialog(
                const Center(
                  child: CircularProgressIndicator(),
                ),
                barrierDismissible: false,
              );
              
              // Logout - clear token and user data
              await _userController.logout();
              
              // Close loading
              Get.back();
              
              // Navigate to login screen and clear all previous routes
              Get.offAllNamed(Routes.AUTH_LOGIN);
              
              // Show success message
              Get.snackbar(
                'Success',
                'Logged out successfully',
                backgroundColor: Colors.black,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(20),
                borderRadius: 10,
              );
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
