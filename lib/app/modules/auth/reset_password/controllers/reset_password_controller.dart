import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../service/apiservice.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isNewPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  final isLoading = false.obs;
  var email = ''.obs;
  var otp = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      email.value = Get.arguments['email'] ?? '';
      otp.value = Get.arguments['otp'] ?? '';
    }
  }

  Future<bool> resetPassword() async { // Returns true on success
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Validate passwords
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black, // Black toast
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return false;
    }

    if (newPassword.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black, // Black toast
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return false;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black, // Black toast
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return false;
    }
    
    if (email.value.isEmpty || otp.value.isEmpty) {
       Get.snackbar(
        'Error',
        'Missing email or OTP information. Please restart process.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black, // Black toast
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return false;
    }

    isLoading.value = true;
    try {
      print('Resetting password for: ${email.value}');
      final apiService = Get.find<ApiService>();
      final success = await apiService.resetPassword(email.value, otp.value, newPassword);

      if (success) {
         // Show success message logic moved to view or here if just snackbar
         // But user wants success dialog. Controller returns success status.
         return true;
      } else {
         Get.snackbar(
            'Error',
            'Failed to reset password. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black, // Black toast
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
          );
          return false;
      }

    } catch (e) {
      print("Error resetPassword: $e");
       Get.snackbar(
          'Error',
          'An unexpected error occurred',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black, // Black toast
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
        return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}