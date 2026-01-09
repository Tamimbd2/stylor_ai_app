import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../service/apiservice.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  // Secure storage for sensitive data (tokens)
  final _secureStorage = const FlutterSecureStorage();
  
  final Rx<User?> user = Rx<User?>(null);
  final RxString token = ''.obs;
  final RxString refreshToken = ''.obs;
  final RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromSecureStorage();
  }

  // Load data from secure storage
  Future<void> _loadFromSecureStorage() async {
    try {
      token.value = await _secureStorage.read(key: 'token') ?? '';
      refreshToken.value = await _secureStorage.read(key: 'refreshToken') ?? '';
      final userData = await _secureStorage.read(key: 'user');
      
      if (userData != null && userData.isNotEmpty) {
        user.value = User.fromJson(jsonDecode(userData));
      }
      
      print('Token loaded: ${token.value.isNotEmpty ? "Yes" : "No"}');
      print('User loaded: ${user.value?.name ?? "No user"}');
    } catch (e) {
      print('Error loading from secure storage: $e');
    } finally {
      isInitialized.value = true;
    }
  }

  bool get isLoggedIn => token.isNotEmpty;

  // Save login data to secure storage
  Future<void> login(String newToken, String newRefreshToken, User newUser) async {
    try {
      token.value = newToken;
      refreshToken.value = newRefreshToken;
      user.value = newUser;
      
      await _secureStorage.write(key: 'token', value: newToken);
      await _secureStorage.write(key: 'refreshToken', value: newRefreshToken);
      await _secureStorage.write(key: 'user', value: jsonEncode(newUser.toJson()));
      
      print('Login data saved securely');
    } catch (e) {
      print('Error saving login data: $e');
    }
  }

  // Clear all secure storage on logout
  Future<void> logout() async {
    try {
      token.value = '';
      refreshToken.value = '';
      user.value = null;
      
      await _secureStorage.delete(key: 'token');
      await _secureStorage.delete(key: 'refreshToken');
      await _secureStorage.delete(key: 'user');
      
      print('Logout: All data cleared');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // Update user data
  Future<void> updateUser(User updatedUser) async {
    try {
      user.value = updatedUser;
      await _secureStorage.write(key: 'user', value: jsonEncode(updatedUser.toJson()));
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Update avatar
  Future<void> updateAvatar(String newAvatarUrl) async {
    if (user.value != null) {
      user.value!.avatar = newAvatarUrl;
      user.refresh();
      await _secureStorage.write(key: 'user', value: jsonEncode(user.value!.toJson()));
    }
  }

  // Fetch user from API
  Future<void> fetchUser() async {
    try {
      if (Get.isRegistered<ApiService>()) {
          final apiService = Get.find<ApiService>();
          final fetchedUser = await apiService.getMe();
          if (fetchedUser != null) {
            await updateUser(fetchedUser);
          }
      } else {
        // Fallback or lazy put
        Get.put(ApiService());
        final apiService = Get.find<ApiService>();
          final fetchedUser = await apiService.getMe();
          if (fetchedUser != null) {
            await updateUser(fetchedUser);
          }
      }
    } catch (e) {
      print('Fetch user error: $e');
    }
  }
}
