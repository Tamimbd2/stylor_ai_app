import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../app/models/user_model.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    // Select URL based on platform
    if (kIsWeb) {
      baseUrl = 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      // 10.0.2.2 is the special IP for Android Emulator to access host's localhost
      baseUrl = 'http://10.0.2.2:3000'; 
    } else {
      // iOS, Windows, macOS
      baseUrl = 'http://localhost:3000';
    }
    
    timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<LoginResponse?> login(String email, String password) async {
    final response = await post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (response.status.hasError) {
      // Print error for debugging
      print('API Error: ${response.statusCode} - ${response.statusText}');
      print('API Body: ${response.body}');
      return Future.error(response.statusText ?? 'Unknown Error');
    } else {
      return LoginResponse.fromJson(response.body);
    }
  }

  // Register
  Future<LoginResponse?> register(String fullName, String email, String password) async {
    final response = await post('/auth/register', {
      'fullName': fullName,
      'email': email,
      'password': password,
    });

    if (response.status.hasError) {
      // Print error for debugging
      print('API Error: ${response.statusCode} - ${response.statusText}');
      print('API Body: ${response.body}');
      return Future.error(response.statusText ?? 'Unknown Error');
    } else {
      return LoginResponse.fromJson(response.body);
    }
  }

  // Google Login
  Future<LoginResponse?> googleLogin(String idToken) async {
    final response = await post('/auth/google/mobile', {
      'idToken': idToken,
    });

    if (response.status.hasError) {
      print('API Error: ${response.statusCode} - ${response.statusText}');
      print('API Body: ${response.body}');
      return Future.error(response.statusText ?? 'Unknown Error');
    } else {
      return LoginResponse.fromJson(response.body);
    }
  }
}
