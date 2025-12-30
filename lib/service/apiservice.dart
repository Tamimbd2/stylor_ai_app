import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../app/controllers/user_controller.dart';
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

  // Upload Avatar
  Future<String?> uploadAvatar(File file) async {
    try {
      // Get token from UserController
      final userController = Get.find<UserController>();
      final token = userController.token.value;

      if (token.isEmpty) {
        return Future.error('Not authenticated');
      }

      String fileName = file.path.split(Platform.pathSeparator).last;
      String extension = fileName.split('.').last.toLowerCase();
      String contentType = 'image/jpeg'; // default
      
      if (extension == 'png') {
        contentType = 'image/png';
      } else if (extension == 'webp') {
        contentType = 'image/webp';
      } else if (extension == 'gif') {
        contentType = 'image/gif';
      }

      final form = FormData({
        'file': MultipartFile(file, filename: fileName, contentType: contentType),
      });

      final response = await post(
        '/upload/avatar',
        form,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.status.hasError) {
        print('Upload Error: ${response.statusCode} - ${response.statusText}');
        print('Upload Body: ${response.body}');
        return Future.error(response.statusText ?? 'Upload Failed');
      } else {
        print('Upload Success: ${response.body}');
        
        String? relativeUrl;
        final data = response.body;

        if (data is Map) {
          if (data.containsKey('avatarUrl')) {
             relativeUrl = data['avatarUrl'];
          } else if (data.containsKey('user') && data['user'] is Map && data['user'].containsKey('avatar')) {
             relativeUrl = data['user']['avatar'];
          } else if (data.containsKey('avatar')) {
             relativeUrl = data['avatar'];
          } else if (data.containsKey('url')) {
             relativeUrl = data['url'];
          }
        }
        
        if (relativeUrl != null) {
          // If relative path, prepend base url
          if (relativeUrl.startsWith('/')) {
             // Remove trailing slash from base if exists? (GetConnect base usually doesn't have it if I set it manually)
             // My baseUrl set in onInit is 'http://10.0.2.2:3000' or 'http://localhost:3000'
             // So simply concatenating is fine.
             return '$baseUrl$relativeUrl';
          }
          return relativeUrl;
        }
        
        return null;
      }
    } catch (e) {
      print('Exception during upload: $e');
      return null;
    }
  }
}
