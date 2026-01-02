import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart'; // Commented out to prevent MissingPluginException
import '../../../../../service/apiservice.dart';

class OtpController extends GetxController {
  
  var email = ''.obs;
  var otpString = '';

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      email.value = Get.arguments['email'] ?? '';
    }
  }

  String get otpCode => otpString;

  void setOtp(String code) {
    print('OTP Code Updated: $code');
    otpString = code;
  }

  Future<void> verifyOtp() async {
    print('Attempting to verify OTP...'); // Console log
    if (otpCode.length == 6) {
      if (email.value.isEmpty) {
        print('Error: Email not found');
        Get.snackbar(
          'Error',
          'Email not found. Please go back.',
          backgroundColor: Colors.black, // Toast black color
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
        return;
      }

      isVerifying.value = true;
      try {
        final apiService = Get.find<ApiService>();
        
        final success = await apiService.verifyOtp(email.value, otpCode);
        
        if (success) {
          print('OTP Verified Successfully'); // Console log
          Get.snackbar(
            'Success', 
            'OTP Verified Successfully',
            backgroundColor: Colors.black, // Toast black color
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
          );
          // Navigate to Reset Password Screen with email and otp
          Get.toNamed('/reset-password', arguments: {'email': email.value, 'otp': otpCode});
        } else {
          print('Error: Invalid OTP');
          Get.snackbar(
            'Error', 
            'Invalid OTP. Please try again.',
            backgroundColor: Colors.black, // Toast black color
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
          );
        }
      } catch (e) {
        print("Error verifyOtp: $e");
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
        isVerifying.value = false;
      }

    } else {
      print('Error: Incomplete OTP code');
      Get.snackbar(
        'Error', 
        'Please enter complete OTP code',
        backgroundColor: Colors.black, // Toast black color
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  final isVerifying = false.obs;
  final isResending = false.obs;

  Future<void> resendCode() async {
    print('Attempting to resend code...'); // Console log
    if (email.value.isEmpty) {
      print('Error: Email not found for resend');
      Get.snackbar(
        'Error', 
        'Email not found. Please go back and try again.',
        backgroundColor: Colors.black, // Toast black color
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    isResending.value = true;
    try {
      final apiService = Get.find<ApiService>();
      
      final success = await apiService.requestPasswordReset(email.value);
      
      if (success) {
        print('Verification code resent successfully'); // Console log
        Get.snackbar(
          'Success', 
          'Verification code resent to your email',
          backgroundColor: Colors.black, // Toast black color
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
        // Clear existing OTP
        otpString = '';
      } else {
        print('Error: Failed to resend verification code');
        Get.snackbar(
          'Error', 
          'Failed to resend verification code. Please try again.',
          backgroundColor: Colors.black, // Toast black color
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
        );
      }
    } catch (e) {
      print("Error in resendCode: $e");
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
      isResending.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}