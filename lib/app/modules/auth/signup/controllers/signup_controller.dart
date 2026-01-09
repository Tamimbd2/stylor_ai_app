import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit/service/apiservice.dart';
import '../../../../controllers/user_controller.dart';

class SignupController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final isLoading = false.obs;

  Future<bool> register(String fullName, String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _apiService.register(fullName, email, password);
      
      if (response != null && response.token != null && response.user != null) {
        // Save to global user controller (now async)
        await Get.find<UserController>().login(
          response.token!, 
          response.refreshToken ?? '', 
          response.user!
        );
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
