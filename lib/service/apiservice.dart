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
    
    timeout = const Duration(seconds: 120); // Increased for AI generation
    
    // Allow self-signed certificates for development
    allowAutoSignedCert = true;
    
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
      print('Generate Fashion Error: No token');
      return null;
    }

    print('Generate Fashion Request: option=$option, temperature=$temperature');

    try {
      final response = await post(
        '/fashion/generate',
        {
          'option': option,
          'temperature': temperature,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 200), // Increased timeout for AI generation
        onTimeout: () {
          print('Generate Fashion: Request timed out after 120 seconds');
          return Response(
            statusCode: 408,
            statusText: 'Request Timeout',
          );
        },
      );

      if (response.status.hasError) {
        print('Generate Fashion Error: ${response.statusCode} - ${response.statusText}');
        print('Generate Fashion Body: ${response.body}');
        return null;
      } else {
        print('Generate Fashion Success: ${response.body}');
        if (response.body is Map<String, dynamic>) {
          return response.body;
        }
        return null;
      }
    } catch (e) {
      print('Generate Fashion Exception: $e');
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

  // Get Wardrobe Items
  Future<List<Map<String, dynamic>>?> getWardrobe() async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      return null;
    }

    final response = await get(
      '/fashion/wardrobe',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.status.hasError) {
      print('Get Wardrobe Error: ${response.statusCode} - ${response.statusText}');
      print('Get Wardrobe Body: ${response.body}');
      return null;
    } else {
      print('Get Wardrobe Success: ${response.body}');
      try {
        if (response.body is Map && response.body['items'] != null) {
          final items = response.body['items'] as List;
          return items.map((item) {
            // Fix image path to full URL
            if (item['image_path'] != null && item['image_path'].startsWith('/')) {
              item['image_url'] = '$baseUrl${item['image_path']}';
            } else {
              item['image_url'] = item['image_path'];
            }
            return item as Map<String, dynamic>;
          }).toList();
        }
      } catch (e) {
        print("Error parsing wardrobe items: $e");
      }
      return null;
    }
  }

  // Search Products
  Future<Map<String, dynamic>?> searchProducts({
    required String queries,
    int limit = 5,
    int offset = 0,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('Search Products Error: No token');
      return null;
    }

    // URL encode the queries
    final encodedQueries = Uri.encodeComponent(queries);
    
    // Build path with query parameters
    final path = '/fashion/search?queries=$encodedQueries&limit=$limit&offset=$offset';
    
    print('🔍 Search Products Request: $baseUrl$path');

    try {
      final response = await get(
        path,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.status.hasError) {
        print('Search Products Error: ${response.statusCode} - ${response.statusText}');
        print('Search Products Body: ${response.body}');
        return null;
      } else {
        print('Search Products Success: ${response.body}');
        if (response.body is Map<String, dynamic>) {
          return response.body;
        }
        return null;
      }
    } catch (e) {
      print('Search Products Exception: $e');
      return null;
    }
  }

  // Add product to favorites
  Future<Map<String, dynamic>?> addToFavorites({
    required String productName,
    required String productUrl,
    required String imageUrl,
    required String price,
    required String searchQuery,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('Add to Favorites Error: No token');
      return null;
    }

    final body = {
      'product_name': productName,
      'product_url': productUrl,
      'image_url': imageUrl,
      'price': price,
      'search_query': searchQuery,
    };

    print('❤️ Adding to favorites: $productName');

    try {
      final response = await post(
        '/fashion/favorite',
        body,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.status.hasError) {
        print('Add to Favorites Error: ${response.statusCode} - ${response.statusText}');
        print('Add to Favorites Body: ${response.body}');
        return null;
      } else {
        print('Add to Favorites Success: ${response.body}');
        if (response.body is Map<String, dynamic>) {
          return response.body;
        }
        return null;
      }
    } catch (e) {
      print('Add to Favorites Exception: $e');
      return null;
    }
  }

  // Remove product from favorites
  Future<bool> removeFromFavorites({
    required String favoriteId,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Remove from Favorites: No token');
      return false;
    }

    print('💔 Removing from favorites: ID $favoriteId');

    try {
      // Use request() with DELETE and empty body to satisfy Content-Type requirement
      final response = await request(
        '/fashion/favorite/$favoriteId',
        'DELETE',
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {}, // Empty body to satisfy Content-Type: application/json
      );

      print('📡 Delete Response Status: ${response.statusCode}');
      print('📡 Delete Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('✅ Successfully removed from favorites');
        return true;
      } else {
        print('❌ Remove failed: ${response.statusCode}');
        print('❌ Error body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('❌ Remove exception: $e');
      return false;
    }
  }

  // Add product to cart
  Future<Map<String, dynamic>?> addToCart({
    required String title,
    required String price,
    required String buyNowUrl,
    required String imageUrl,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Add to Cart: No token');
      return null;
    }

    final body = {
      'title': title,
      'price': price,
      'buy_now_url': buyNowUrl,
      'image_url': imageUrl,
    };

    print('🛒 Adding to cart: $title');

    try {
      final response = await post(
        '/cart',
        body,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.status.hasError) {
        print('❌ Add to Cart Error: ${response.statusCode}');
        print('   Body: ${response.body}');
        return null;
      } else {
        print('✅ Add to Cart Success: ${response.body}');
        if (response.body is Map<String, dynamic>) {
          return response.body;
        }
        return null;
      }
    } catch (e) {
      print('❌ Add to Cart Exception: $e');
      return null;
    }
  }

  // Add outfit to favorites
  Future<Map<String, dynamic>?> addOutfitToFavorites({
    required String imageUrl,
    required String title,
    required String description,
    required List<Map<String, String>> products,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Add Outfit to Favorites: No token');
      return null;
    }

    final body = {
      'image_url': imageUrl,
      'title': title,
      'description': description,
      'products': products,
    };

    print('❤️ Adding outfit to favorites: $title');

    try {
      final response = await post(
        '/fashion/outfit/favorite',
        body,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.status.hasError) {
        print('❌ Add Outfit to Favorites Error: ${response.statusCode}');
        print('   Body: ${response.body}');
        return null;
      } else {
        print('✅ Add Outfit to Favorites Success: ${response.body}');
        if (response.body is Map<String, dynamic>) {
          return response.body;
        }
        return null;
      }
    } catch (e) {
      print('❌ Add Outfit to Favorites Exception: $e');
      return null;
    }
  }

  // Remove outfit from favorites
  Future<bool> removeOutfitFromFavorites({
    required String outfitFavoriteId,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Remove Outfit from Favorites: No token');
      return false;
    }

    print('💔 Removing outfit from favorites: ID $outfitFavoriteId');

    try {
      final response = await request(
        '/fashion/outfit/favorite/$outfitFavoriteId',
        'DELETE',
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {}, // Empty body to satisfy Content-Type requirement
      );

      print('📡 Delete Outfit Response Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('✅ Successfully removed outfit from favorites');
        return true;
      } else {
        print('❌ Remove outfit failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Remove outfit exception: $e');
      return false;
    }
  }

  // Get cart items
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Get Cart Items: No token');
      return [];
    }

    print('🛒 Fetching cart items...');

    try {
      final response = await get(
        '/cart',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.status.hasError) {
        print('❌ Get Cart Items Error: ${response.statusCode}');
        print('   Body: ${response.body}');
        return [];
      } else {
        print('✅ Get Cart Items Success');
        
        // Response is directly an array
        if (response.body is List) {
          print('📦 Found ${response.body.length} items in cart');
          return (response.body as List).cast<Map<String, dynamic>>();
        } else if (response.body is Map<String, dynamic> && response.body['items'] != null) {
          final items = response.body['items'] as List;
          print('📦 Found ${items.length} items in cart');
          return items.cast<Map<String, dynamic>>();
        }
        
        return [];
      }
    } catch (e) {
      print('❌ Get Cart Items Exception: $e');
      return [];
    }
  }

  // Remove item from cart
  Future<bool> removeFromCart({
    required String cartItemId,
  }) async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Remove from Cart: No token');
      return false;
    }

    print('🗑️ Removing from cart: ID $cartItemId');

    try {
      final response = await request(
        '/cart/$cartItemId',
        'DELETE',
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {}, // Empty body to satisfy Content-Type requirement
      );

      print('📡 Delete Cart Response Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('✅ Successfully removed from cart');
        return true;
      } else {
        print('❌ Remove from cart failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Remove from cart exception: $e');
      return false;
    }
  }

  // Get favorite products
  Future<List<Map<String, dynamic>>> getFavoriteProducts() async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Get Favorite Products: No token');
      return [];
    }

    print('❤️ Fetching favorite products...');

    try {
      final response = await get(
        '/fashion/favorites',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.status.hasError) {
        print('❌ Get Favorite Products Error: ${response.statusCode}');
        print('   Body: ${response.body}');
        return [];
      } else {
        print('✅ Get Favorite Products Success');
        
        // Response is directly an array
        if (response.body is List) {
          print('📦 Found ${response.body.length} favorite products');
          return (response.body as List).cast<Map<String, dynamic>>();
        } else if (response.body is Map<String, dynamic> && response.body['favorites'] != null) {
          final favorites = response.body['favorites'] as List;
          print('📦 Found ${favorites.length} favorite products');
          return favorites.cast<Map<String, dynamic>>();
        }
        
        return [];
      }
    } catch (e) {
      print('❌ Get Favorite Products Exception: $e');
      return [];
    }
  }

  // Get favorite outfits
  Future<List<Map<String, dynamic>>> getFavoriteOutfits() async {
    final userController = Get.find<UserController>();
    final token = userController.token.value;

    if (token.isEmpty) {
      print('❌ Get Favorite Outfits: No token');
      return [];
    }

    print('👗 Fetching favorite outfits...');

    try {
      final response = await get(
        '/fashion/outfit/favorites',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.status.hasError) {
        print('❌ Get Favorite Outfits Error: ${response.statusCode}');
        print('   Body: ${response.body}');
        return [];
      } else {
        print('✅ Get Favorite Outfits Success');
        
        // Response is directly an array
        if (response.body is List) {
          print('📦 Found ${response.body.length} favorite outfits');
          return (response.body as List).cast<Map<String, dynamic>>();
        } else if (response.body is Map<String, dynamic> && response.body['outfits'] != null) {
          final outfits = response.body['outfits'] as List;
          print('📦 Found ${outfits.length} favorite outfits');
          return outfits.cast<Map<String, dynamic>>();
        }
        
        return [];
      }
    } catch (e) {
      print('❌ Get Favorite Outfits Exception: $e');
      return [];
    }
  }
}
