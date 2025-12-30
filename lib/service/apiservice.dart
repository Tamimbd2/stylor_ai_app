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

  // Helper to fix avatar URL
  User _fixUserAvatar(User user) {
    if (user.avatar != null && user.avatar!.startsWith('/')) {
       // Ensure no double slash if baseUrl ends with /
       if (baseUrl != null && baseUrl!.endsWith('/')) {
          user.avatar = '${baseUrl!.substring(0, baseUrl!.length - 1)}${user.avatar}';
       } else {
          user.avatar = '$baseUrl${user.avatar}';
       }
    }
    return user;
  }

  Future<LoginResponse?> login(String email, String password) async {
    final response = await post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (response.status.hasError) {
      print('API Error: ${response.statusCode} - ${response.statusText}');
      print('API Body: ${response.body}');
      return Future.error(response.statusText ?? 'Unknown Error');
    } else {
      final loginResponse = LoginResponse.fromJson(response.body);
      if (loginResponse.user != null) {
        _fixUserAvatar(loginResponse.user!);
      }
      return loginResponse;
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
      print('API Error: ${response.statusCode} - ${response.statusText}');
      print('API Body: ${response.body}');
      return Future.error(response.statusText ?? 'Unknown Error');
    } else {
      final loginResponse = LoginResponse.fromJson(response.body);
      if (loginResponse.user != null) {
        _fixUserAvatar(loginResponse.user!);
      }
      return loginResponse;
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
      final loginResponse = LoginResponse.fromJson(response.body);
      if (loginResponse.user != null) {
        _fixUserAvatar(loginResponse.user!);
      }
      return loginResponse;
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

  // Update User Profile
  Future<User?> updateUserProfile({
    required String birthdate,
    required String gender,
    required String country,
    required Map<String, dynamic> fashionPreferences,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      return Future.error('Not authenticated');
    }

    final response = await post(
      '/user/profile/update',
      {
        'birthdate': birthdate,
        'gender': gender,
        'country': country,
        // 'avatar': ...
        'fashionPreferences': fashionPreferences,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.status.hasError) {
      print('Update Profile Error: ${response.statusCode} - ${response.statusText}');
      print('Update Profile Body: ${response.body}');
      return Future.error(response.statusText ?? 'Update Failed');
    } else {
      print('Update Profile Success: ${response.body}');
      try {
        if (response.body is Map && response.body['user'] != null) {
          final user = User.fromJson(response.body['user']);
          return _fixUserAvatar(user);
        }
      } catch (e) {
        print("Error parsing user: $e");
      }
      return null;
    }
  }

  // Get Me
  Future<User?> getMe() async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      return null;
    }

    final response = await get(
      '/auth/me',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.status.hasError) {
      print('Get Me Error: ${response.statusCode} - ${response.statusText}');
      print('Get Me Body: ${response.body}');
      return null;
    } else {
      print('Get Me Success: ${response.body}');
      try {
        if (response.body is Map && response.body['user'] != null) {
           final user = User.fromJson(response.body['user']);
           return _fixUserAvatar(user);
        }
      } catch (e) {
        print("Error parsing user me: $e");
      }
      return null;
    }
  }
}
