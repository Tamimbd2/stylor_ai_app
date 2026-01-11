import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart'; // Commented out to prevent MissingPluginException
import '../../../../../service/apiservice.dart';

/// Controller (create this file separately)
class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendOtp() async {
    print('📧 Attempting to send OTP...');
    
    if (emailController.text.isEmpty) {
      print('❌ Error: Email address empty');
      Get.snackbar(
        'Error', 
        'Please enter your email address',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    // Validate email format
    if (!GetUtils.isEmail(emailController.text.trim())) {
      print('❌ Error: Invalid email format');
      Get.snackbar(
        'Error', 
        'Please enter a valid email address',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    isLoading.value = true;
    try {
      // Use Get.put to ensure ApiService is initialized
      final apiService = Get.put(ApiService());
      
      print('📤 Sending password reset request for: ${emailController.text.trim()}');
      final success = await apiService.requestPasswordReset(emailController.text.trim());
      
      if (success) {
        print('✅ OTP sent successfully');
        Get.snackbar(
          'Success', 
          'Verification code sent to your email',
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        );
        
        // Navigate to OTP screen
        await Future.delayed(const Duration(milliseconds: 500));
        Get.toNamed('/otp', arguments: {'email': emailController.text.trim()}); 
      }
    } catch (e) {
      print('❌ Error in sendOtp: $e');
      
      // Extract user-friendly error message
      String errorMessage = e.toString();
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceAll('Exception:', '').trim();
      }
      
      // Make error messages more user-friendly
      if (errorMessage.contains('Failed to process password reset request') || 
          errorMessage.contains('500')) {
        errorMessage = 'Email not found. Please check your email address or sign up first.';
      } else if (errorMessage.contains('Network') || errorMessage.contains('connection')) {
        errorMessage = 'Network error. Please check your internet connection.';
      }
      
      Get.snackbar(
        'Error', 
        errorMessage,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.error_outline, color: Colors.white),
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
