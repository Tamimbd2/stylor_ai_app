import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final List<TextEditingController> otpControllers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );

  String get otpCode {
    return otpControllers.map((controller) => controller.text).join();
  }

  void verifyOtp() {
    if (otpCode.length == 4) {
      // Implement your OTP verification logic here
      print('Verifying OTP: $otpCode');
      // Add your API call or navigation logic
    } else {
      Get.snackbar(
        'Error',
        'Please enter complete OTP code',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void resendCode() {
    // Implement resend OTP logic here
    print('Resending OTP code');
    // Clear existing OTP
    for (var controller in otpControllers) {
      controller.clear();
    }
    // Focus first field
    focusNodes[0].requestFocus();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}