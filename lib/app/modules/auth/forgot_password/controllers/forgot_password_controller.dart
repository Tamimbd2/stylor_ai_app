import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

/// Controller (create this file separately)
class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  void sendOtp() {
    // Implement your OTP sending logic here
    if (emailController.text.isNotEmpty) {
      // Add your API call or navigation logic

      print('Sending OTP to: ${emailController.text}');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
