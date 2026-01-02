import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart'; // Commented out to prevent MissingPluginException
import '../../../../../service/apiservice.dart';

/// Controller (create this file separately)
class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendOtp() async {
    print('Attempting to send OTP...'); // Console log
    if (emailController.text.isEmpty) {
      print('Error: Email address empty');
      Get.snackbar(
        'Error', 
        'Please enter your email address',
        backgroundColor: Colors.black, // Toast black color
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    isLoading.value = true;
    try {
      final apiService = Get.find<ApiService>();
      
      final success = await apiService.requestPasswordReset(emailController.text);
      
      if (success) {
        print('OTP sent successfully'); // Console log
        Get.snackbar(
          'Success', 
          'Verification code sent to your email',
          backgroundColor: Colors.black, // Toast black color
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
        Get.toNamed('/otp', arguments: {'email': emailController.text}); 
      } else {
        print('Error: Failed to send OTP');
        Get.snackbar(
          'Error', 
          'Failed to send verification code. Please try again.',
          backgroundColor: Colors.black, // Toast black color
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
      }
    } catch (e) {
      print("Error in sendOtp: $e");
      Get.snackbar(
        'Error', 
        'An unexpected error occurred',
        backgroundColor: Colors.black, // Toast black color
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
