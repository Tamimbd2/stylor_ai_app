// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outfit/service/apiservice.dart';
import '../../../../controllers/user_controller.dart';

class AuthLoginController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final isLoading = false.obs;
  // ⚠️ IMPORTANT: Replace with your Web Client ID from Google Cloud Console
  // This is required for the backend to verify the token.
  // Format: "1234567890-abcdefgh.apps.googleusercontent.com"
  static const String _serverClientId = '276093179006-c55utgcbulsrba2vo29ps2qdtc6g9ajl.apps.googleusercontent.com'; 

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: _serverClientId,
  );
  
  final _storage = GetStorage();
  final savedEmail = ''.obs;
  final savedPassword = ''.obs;
  final isRememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedCredentials();
  }

  void loadSavedCredentials() {
    isRememberMe.value = _storage.read('remember_me') ?? false;
    if (isRememberMe.value) {
      savedEmail.value = _storage.read('saved_email') ?? '';
      savedPassword.value = _storage.read('saved_password') ?? '';
      // print("Loaded credentials: ${savedEmail.value}");
    }
  }


  Future<bool> login(String email, String password, {bool rememberMe = false}) async {
    try {
      isLoading.value = true;
      final response = await _apiService.login(email, password);
      
      if(response != null && response.token != null && response.user != null){
        // Save to global user controller (now async)
        await Get.find<UserController>().login(response.token!, response.refreshToken ?? '', response.user!);

        if (rememberMe) {
          _storage.write('remember_me', true);
          _storage.write('saved_email', email);
          _storage.write('saved_password', password);
        } else {
          _storage.write('remember_me', false);
          _storage.remove('saved_email');
          _storage.remove('saved_password');
        }
        return true;
      }
      return false;

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
        // Print token safely in chunks to avoid truncation
        print("\n👇 GOOGLE ID TOKEN (FULL) 👇");
        const int chunkSize = 800;
        for (int i = 0; i < idToken.length; i += chunkSize) {
          int end = (i + chunkSize < idToken.length) ? i + chunkSize : idToken.length;
          print(idToken.substring(i, end));
        }
        print("☝️ GOOGLE ID TOKEN (END) ☝️\n");
        
        if (_serverClientId == null) {
          print("⚠️ WARNING: _serverClientId is null. Backend verification requires a Web Client ID.");
        }

        final response = await _apiService.googleLogin(idToken);
        if (response != null && response.token != null && response.user != null) {
          // Save to global user controller (now async)
          await Get.find<UserController>().login(response.token!, response.refreshToken ?? '', response.user!);
          return true;
        }
      } else {
        throw 'Could not get ID Token from Google';
      }
      return false;
    } catch (e) {
      String errorMessage = e.toString();
      
      // Handle Common Google Sign In Errors
      if (errorMessage.contains('ApiException: 10')) {
        errorMessage = 'Configuration Error (Code 10):\n'
            '1.  Check SHA-1 fingerprint in Firebase.\n'
            '2.  Ensure correct google-services.json.\n'
            '3.  Set Support Email in Firebase Console.';
        print("❌ GOOGLE SIGN IN ERROR: $errorMessage");
      }

      Get.snackbar(
        'Google Login Failed',
        errorMessage,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        duration: const Duration(seconds: 5),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

