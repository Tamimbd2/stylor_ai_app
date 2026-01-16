// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:outfit/service/apiservice.dart';
import '../../../../controllers/user_controller.dart';

class SignupController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final isLoading = false.obs;

  // ⚠️ IMPORTANT: Replace with your Web Client ID from Google Cloud Console
  // This is required for the backend to verify the token.
  static const String _serverClientId = '276093179006-c55utgcbulsrba2vo29ps2qdtc6g9ajl.apps.googleusercontent.com'; 

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: _serverClientId,
  );

  Future<bool> handleGoogleSignUp() async {
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

        // Reuse the same googleLogin API. Usually backend handles signup/login transparently if user doesn't exist.
        final response = await _apiService.googleLogin(idToken);
        if (response != null && response.token != null && response.user != null) {
          // Save to global user controller (now async)
          await Get.find<UserController>().login(response.token!, response.refreshToken ?? '', response.user!);
          
          Get.snackbar(
            'Success',
            'Google Sign-Up Successful!',
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
          
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

  Future<bool> register(String fullName, String email, String password) async {
    try {
      isLoading.value = true;
      print('📝 Attempting registration:');
      print('   Email: $email');
      print('   Full Name: $fullName');
      
      final response = await _apiService.register(fullName, email, password);
      
      if (response != null && response.user != null) {
        print('✅ Registration successful!');
        print('   User Email: ${response.user!.email}');
        print('   User Name from API: ${response.user!.name}');
        
        // Workaround: If API returns "User" as name, use the fullName we sent
        if (response.user!.name == null || 
            response.user!.name == 'User' || 
            response.user!.name!.isEmpty) {
          print('⚠️ API returned default name, using signup fullName: $fullName');
          response.user!.name = fullName;
        }
        
        // Check if we have a token
        if (response.token != null) {
          // Normal case: token is present
          await Get.find<UserController>().login(
            response.token!, 
            response.refreshToken ?? '', 
            response.user!
          );
        } else {
          // Special case: API returned user but no token
          // We need to login to get a token
          print('⚠️ No token from register, attempting automatic login...');
          
          try {
            final loginResponse = await _apiService.login(email, password);
            
            if (loginResponse != null && loginResponse.token != null && loginResponse.user != null) {
              print('✅ Automatic login successful, got token');
              
              // Fix name in login response too
              if (loginResponse.user!.name == null || 
                  loginResponse.user!.name == 'User' || 
                  loginResponse.user!.name!.isEmpty) {
                print('⚠️ Login response also has default name, using signup fullName: $fullName');
                loginResponse.user!.name = fullName;
              }
              
              await Get.find<UserController>().login(
                loginResponse.token!, 
                loginResponse.refreshToken ?? '', 
                loginResponse.user!
              );
            } else {
              throw Exception('Failed to get token after registration');
            }
          } catch (loginError) {
            print('❌ Automatic login failed: $loginError');
            throw Exception('Registration successful but failed to login. Please login manually.');
          }
        }
        
        Get.snackbar(
          'Success',
          'Account created successfully!',
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          borderRadius: 10,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        );
        
        return true;
      }
      
      // If response is null or incomplete
      Get.snackbar(
        'Registration Failed',
        'Invalid response from server. Please try again.',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return false;
    } catch (e) {
      print('❌ Registration error: $e');
      
      // Show user-friendly error message
      String errorMessage = e.toString();
      
      // Clean up error message if it's too technical
      if (errorMessage.contains('Exception:')) {
        errorMessage = errorMessage.replaceAll('Exception:', '').trim();
      }
      
      Get.snackbar(
        'Registration Failed',
        errorMessage,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
