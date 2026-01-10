import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/product_model.dart';
import '../../../../service/apiservice.dart';

class OutputOutfitController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

  // Selected outfit data
  final outfitImageUrl = ''.obs;
  final outfitDescription = ''.obs;
  final outfitQueries = ''.obs; // Comma-separated queries

  // UI state
  final selectedChip = 'All'.obs;
  final isFeaturedOutfitFavorited = false.obs;
  final favoriteProducts = <int>{}.obs;
  final isLoading = false.obs;

  // Products from API
  final allProducts = <ProductModel>[].obs;
  
  // Map to store favorite IDs from server (index -> favoriteId)
  final favoriteIds = <int, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    print('📦 OutputOutfitController.onInit() called');
    
    // Get arguments passed from previous screen
    final args = Get.arguments;
    
    print('📦 Arguments type: ${args.runtimeType}');
    print('📦 Arguments: $args');
    
    if (args != null && args is Map<String, dynamic>) {
      outfitImageUrl.value = args['imageUrl'] ?? '';
      outfitDescription.value = args['description'] ?? '';
      outfitQueries.value = args['queries'] ?? '';

      print('📦 OutputOutfit received:');
      print('   Image: ${outfitImageUrl.value}');
      print('   Description: ${outfitDescription.value}');
      print('   Queries: ${outfitQueries.value}');

      // Fetch products if queries are available
      if (outfitQueries.value.isNotEmpty) {
        print('✅ Queries found, calling searchProducts()');
        searchProducts();
      } else {
        print('⚠️ No queries found, skipping search');
      }
    } else {
      print('❌ No arguments received or invalid format');
    }
  }

  // Filtered products based on selected category
  List<ProductModel> get filteredProducts {
    if (selectedChip.value == 'All') {
      return allProducts;
    }
    return allProducts
        .where((product) => product.category == selectedChip.value)
        .toList();
  }

  // Search products from API
  Future<void> searchProducts() async {
    try {
      isLoading.value = true;
      allProducts.clear();

      print('🔍 Searching products with queries: ${outfitQueries.value}');

      final response = await _apiService.searchProducts(
        queries: outfitQueries.value,
        limit: 10,
        offset: 0,
      );

      print('📡 API Response received: ${response != null}');
      print('📡 Response keys: ${response?.keys}');
      print('📡 Products key exists: ${response?['products'] != null}');

      if (response != null && response['products'] != null) {
        final productsList = response['products'] as List;

        print('✅ Found ${productsList.length} products in response');

        int successCount = 0;
        for (var i = 0; i < productsList.length; i++) {
          try {
            final productData = productsList[i];
            
            // Parse product data with correct field names
            final product = ProductModel(
              id: productData['product_url']?.toString() ?? '', // Use URL as ID
              name: productData['product_name'] ?? 'Product',
              imagePath: '', // No local asset
              price: _parsePrice(productData['price']),
              category: _detectCategory(productData['product_name'] ?? ''),
              imageUrl: productData['image_url'],
              productUrl: productData['product_url'],
            );

            allProducts.add(product);
            successCount++;
            
            if (i < 3) { // Log first 3 products
              print('   Product $i: ${product.name} - ${product.category} - \$${product.price}');
            }
          } catch (e) {
            print('   ❌ Error parsing product $i: $e');
          }
        }

        print('📦 Successfully loaded $successCount/${productsList.length} products');
        print('📦 Total products in controller: ${allProducts.length}');
        print('📦 Categories: ${allProducts.map((p) => p.category).toSet()}');
      } else {
        print('⚠️ No products found in response');
        print('⚠️ Response: $response');
      }
    } catch (e) {
      print('❌ Error searching products: $e');
      print('❌ Stack trace: ${StackTrace.current}');
      Get.snackbar(
        'Error',
        'Failed to load products',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      print('🏁 Search completed. Loading: ${isLoading.value}');
    }
  }

  // Helper to parse price
  double _parsePrice(dynamic price) {
    if (price == null) return 0.0;
    if (price is num) return price.toDouble();
    if (price is String) {
      // Remove currency symbols and parse
      final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned) ?? 0.0;
    }
    return 0.0;
  }

  // Detect category from product name
  String _detectCategory(String name) {
    final nameLower = name.toLowerCase();

    if (nameLower.contains('shirt') ||
        nameLower.contains('t-shirt') ||
        nameLower.contains('blouse') ||
        nameLower.contains('top') ||
        nameLower.contains('jacket') ||
        nameLower.contains('coat') ||
        nameLower.contains('sweater') ||
        nameLower.contains('hoodie') ||
        nameLower.contains('dress')) {
      return 'Top';
    }

    if (nameLower.contains('pant') ||
        nameLower.contains('trouser') ||
        nameLower.contains('jeans') ||
        nameLower.contains('short') ||
        nameLower.contains('skirt')) {
      return 'bottoms';
    }

    if (nameLower.contains('sunglass') ||
        nameLower.contains('glasses') ||
        nameLower.contains('eyewear')) {
      return 'Sunglass';
    }

    if (nameLower.contains('bag') ||
        nameLower.contains('purse') ||
        nameLower.contains('backpack') ||
        nameLower.contains('handbag')) {
      return 'Bag';
    }

    if (nameLower.contains('watch') || nameLower.contains('clock')) {
      return 'Watch';
    }

    return 'Top'; // Default
  }

  void toggleFeaturedFavorite() {
    isFeaturedOutfitFavorited.value = !isFeaturedOutfitFavorited.value;
  }

  Future<void> toggleProductFavorite(int index) async {
    // Check if already favorited
    final isCurrentlyFavorited = favoriteProducts.contains(index);
    
    if (isCurrentlyFavorited) {
      // Remove from favorites
      favoriteProducts.remove(index);
      print('💔 Removed from favorites (index: $index)');
      
      // If we have a favorite ID, delete from server
      if (favoriteIds.containsKey(index)) {
        final favoriteId = favoriteIds[index]!;
        final success = await _apiService.removeFromFavorites(favoriteId: favoriteId);
        
        if (success) {
          favoriteIds.remove(index);
        }
      }
    } else {
      // Add to favorites
      favoriteProducts.add(index);
      
      // Get product details
      if (index < allProducts.length) {
        final product = allProducts[index];
        
        print('❤️ Adding to favorites: ${product.name}');
        
        // Call API to save to backend
        try {
          final response = await _apiService.addToFavorites(
            productName: product.name,
            productUrl: product.productUrl ?? '',
            imageUrl: product.imageUrl ?? '',
            price: '\$${product.price.toStringAsFixed(2)}',
            searchQuery: outfitQueries.value,
          );
          
          if (response != null) {
            print('✅ Successfully added to favorites on server');
            
            // Store favorite ID from response
            if (response['favorite'] != null && response['favorite']['id'] != null) {
              final favoriteId = response['favorite']['id'].toString();
              favoriteIds[index] = favoriteId;
              print('📝 Stored favorite ID: $favoriteId');
            }
          } else {
            print('⚠️ Failed to add to favorites on server');
          }
        } catch (e) {
          print('❌ Error adding to favorites: $e');
        }
      }
    }
  }

  void selectChip(String chipLabel) {
    selectedChip.value = chipLabel;
  }
}
