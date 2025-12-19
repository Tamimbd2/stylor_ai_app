import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/product_model.dart';

class FavoriteController extends GetxController {
  final isOutfitSelected = false.obs;
  //TODO: Implement FavoriteController

  final count = 0.obs;
  
  // List of favorite products
  final RxList<ProductModel> favoriteProducts = <ProductModel>[].obs;
  



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
  void removeFromFavorites(ProductModel product) {
    favoriteProducts.removeWhere((p) => p.id == product.id);
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
}
