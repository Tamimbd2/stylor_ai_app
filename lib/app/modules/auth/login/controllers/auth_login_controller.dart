import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outfit/service/apiservice.dart';

class AuthLoginController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final isLoading = false.obs;

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _apiService.login(email, password);
      // You can save the token here using GetStorage or SharedPreferences if needed
      // print('Token: ${response?.token}');
      return response != null;
    } catch (e) {
      Get.snackbar(
        'Login Failed',
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
