import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outfit/service/apiservice.dart';

class AuthLoginController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final isLoading = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );


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

  Future<bool> handleGoogleSignIn() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled
        return false;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken != null) {
        print("Google ID Token: $idToken");
        final response = await _apiService.googleLogin(idToken);
        if (response != null && response.token != null) {
          // Success, logic could be here or returned
          return true;
        }
      } else {
        throw 'Could not get ID Token from Google';
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Google Login Failed',
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
