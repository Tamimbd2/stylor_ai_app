import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../service/apiservice.dart';
import '../../../models/product_model.dart';
import '../../../models/outfit_model.dart';


class FavoriteController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  final isOutfitSelected = false.obs;
  final isLoading = false.obs;

  final count = 0.obs;
  
  // List of favorite products
  final RxList<ProductModel> favoriteProducts = <ProductModel>[].obs;
  
  // List of favorite outfits
  final RxList<OutfitModel> favoriteOutfits = <OutfitModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteProducts();
    fetchFavoriteOutfits();
  }

  // Fetch favorite products from server
  Future<void> fetchFavoriteProducts() async {
    try {
      isLoading.value = true;
      favoriteProducts.clear();

      final items = await _apiService.getFavoriteProducts();

      for (var item in items) {
        // Convert API favorite item to ProductModel
        final product = ProductModel(
          id: item['id']?.toString() ?? '',
          name: item['product_name'] ?? 'Product',
          imagePath: '',
          price: _parsePrice(item['price']),
          imageUrl: item['image_url'],
          productUrl: item['product_url'],
        );

        favoriteProducts.add(product);
      }

      print('📦 Loaded ${favoriteProducts.length} favorite products');
    } catch (e) {
      print('❌ Error fetching favorite products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch favorite outfits from server
  Future<void> fetchFavoriteOutfits() async {
    try {
      final items = await _apiService.getFavoriteOutfits();

      favoriteOutfits.clear();

      for (var item in items) {
        // Convert API outfit item to OutfitModel
        final products = <Map<String, String>>[];
        if (item['products'] != null && item['products'] is List) {
          for (var product in item['products']) {
            products.add({
              'title': product['title']?.toString() ?? '',
              'category': product['category']?.toString() ?? '',
            });
          }
        }

        final outfit = OutfitModel(
          id: item['id']?.toString() ?? '',
          imageUrl: item['image_url'] ?? '',
          title: item['title'] ?? 'AI Generated Outfit',
          description: item['description'] ?? '',
          products: products,
        );

        favoriteOutfits.add(outfit);
      }

      print('📦 Loaded ${favoriteOutfits.length} favorite outfits');
    } catch (e) {
      print('❌ Error fetching favorite outfits: $e');
    }
  }

  // Parse price from string
  double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    
    final priceStr = price.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(priceStr) ?? 0.0;
  }

  // Add product to favorites
  void addToFavorites(ProductModel product) {
    // Check if product already exists
    if (!favoriteProducts.any((p) => p.id == product.id)) {
      favoriteProducts.add(product);
      Get.snackbar(
        'Added to Favorites',
        '${product.name} has been added to your favorites',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
      );
    }
  }

  // Remove product from favorites
  Future<void> removeFromFavorites(ProductModel product) async {
    // Remove from local list immediately for instant UI feedback
    favoriteProducts.removeWhere((p) => p.id == product.id);
    
    // Call API to remove from server
    try {
      final success = await _apiService.removeFromFavorites(
        favoriteId: product.id, // product.id is the favorite ID from server
      );
      
      if (!success) {
        print('⚠️ Failed to remove from favorites on server');
        // Optionally re-add to local list if API fails
        // favoriteProducts.add(product);
      }
    } catch (e) {
      print('❌ Error removing from favorites: $e');
    }
  }

  // Check if product is favorited
  bool isFavorited(String productId) {
    return favoriteProducts.any((p) => p.id == productId);
  }

  // Toggle favorite status
  void toggleFavorite(ProductModel product) {
    if (isFavorited(product.id)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }

  // Remove outfit from favorites
  Future<void> removeOutfitFromFavorites(OutfitModel outfit) async {
    // Remove from local list immediately for instant UI feedback
    favoriteOutfits.removeWhere((o) => o.id == outfit.id);
    
    // Call API to remove from server
    try {
      final success = await _apiService.removeOutfitFromFavorites(
        outfitFavoriteId: outfit.id, // outfit.id is the favorite ID from server
      );
      
      if (!success) {
        print('⚠️ Failed to remove outfit from favorites on server');
        // Optionally re-add to local list if API fails
        // favoriteOutfits.add(outfit);
      }
    } catch (e) {
      print('❌ Error removing outfit from favorites: $e');
    }
  }
}
