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
      baseUrl = 'https://api.stylorai.com';
    } else if (Platform.isAndroid) {
      // 10.0.2.2 is the special IP for Android Emulator to access host's localhost
      baseUrl = 'https://api.stylorai.com';
    } else {
      // iOS, Windows, macOS
      baseUrl = 'https://api.stylorai.com';
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
    Map<String, dynamic>? fashionPreferences,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      return Future.error('Not authenticated');
    }

    final Map<String, dynamic> body = {
      'birthdate': birthdate,
      'gender': gender,
      'country': country,
    };

    if (fashionPreferences != null) {
      body['fashionPreferences'] = fashionPreferences;
    }

    final response = await post(
      '/user/profile/update',
      body,
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

  // Generate Fashion Outfit
  Future<Map<String, dynamic>?> generateFashion({
    required String option,
    required double temperature,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      return Future.error('Not authenticated');
    }

    final body = {
      'option': option,
      'temperature': temperature,
    };

    final response = await post(
      '/fashion/generate',
      body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.status.hasError) {
      print('Generate Fashion Error: ${response.statusCode} - ${response.statusText}');
      print('Generate Fashion Body: ${response.body}');
      return Future.error(response.statusText ?? 'Generation Failed');
    } else {
      print('Generate Fashion Success: ${response.body}');
      if (response.body is Map<String, dynamic>) {
        return response.body; 
      }
      return null;
    }
  }

  // Generate Flat Lay
  Future<Map<String, dynamic>?> generateFlatLay(File file) async {
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
      '/fashion/generate-flat-lay',
      form,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.status.hasError) {
      print('Generate Flat Lay Error: ${response.statusCode} - ${response.statusText}');
      print('Generate Flat Lay Body: ${response.body}');
      return Future.error(response.statusText ?? 'Generation Failed');
    } else {
      print('Generate Flat Lay Success: ${response.body}');
      if (response.body is Map<String, dynamic>) {
        return response.body; 
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
  // Request Password Reset
  Future<bool> requestPasswordReset(String email) async {
    final response = await post('/auth/password-reset/request', {
      'email': email,
    });

    if (response.status.hasError) {
      print('Password Reset Request Error: ${response.statusCode} - ${response.statusText}');
      print('Password Reset Request Body: ${response.body}');
      return false; // Or throw error
    } else {
      print('Password Reset Request Success: ${response.body}');
      return true;
    }
  }
  // Verify OTP
  Future<bool> verifyOtp(String email, dynamic otp) async {
    final response = await post('/auth/password-reset/verify-otp', {
      'email': email,
      'otp': otp.toString(),
    });

    if (response.status.hasError) {
      print('Verify OTP Error: ${response.statusCode} - ${response.statusText}');
      print('Verify OTP Body: ${response.body}');
      return false; 
    } else {
      print('Verify OTP Success: ${response.body}');
      return true;
    }
  }
  Future<bool> resetPassword(String email, String otp, String newPassword) async {
    final response = await post('/auth/password-reset/reset', {
      'email': email,
      'otp': otp,
      'newPassword': newPassword,
    });

    if (response.status.hasError) {
      print('Reset Password Error: ${response.statusCode} - ${response.statusText}');
      print('Reset Password Body: ${response.body}');
      return false; 
    } else {
      print('Reset Password Success: ${response.body}');
      return true;
    }
  }
}
