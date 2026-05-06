import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../models/product_model.dart';
import '../../../services/product_recommendation_filter_service.dart';
import '../../../../service/apiservice.dart';

class OutputOutfitController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final ProductRecommendationFilterService _filterService =
      const ProductRecommendationFilterService();

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
  
  // Store outfit favorite ID from server
  final outfitFavoriteId = ''.obs;

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
        final productsList = (response['products'] as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        final queryTokens =
            _filterService.parseQueryTokens(outfitQueries.value);

        print('✅ Found ${productsList.length} products in response');

        final rankedProducts = _filterService.rankProducts(
          rawProducts: productsList,
          queryTokens: queryTokens,
        );

        allProducts.assignAll(rankedProducts);

        for (var i = 0; i < rankedProducts.length && i < 3; i++) {
          final product = rankedProducts[i];
          print(
            '   Product $i: ${product.name} - ${product.category} - score=${product.recommendationScore}',
          );
        }

        print(
          '📦 Successfully ranked ${rankedProducts.length}/${productsList.length} products',
        );
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

  void toggleFeaturedFavorite() async {
    print('🔄 toggleFeaturedFavorite called');
    print('   Current state: ${isFeaturedOutfitFavorited.value}');
    print('   Outfit favorite ID: ${outfitFavoriteId.value}');
    
    isFeaturedOutfitFavorited.value = !isFeaturedOutfitFavorited.value;
    
    print('   New state: ${isFeaturedOutfitFavorited.value}');
    
    if (isFeaturedOutfitFavorited.value) {
      // Adding to favorites
      print('➕ Adding outfit to favorites...');
      try {
        // Get products from the outfit data passed from ShapeselectView
        final productsList = <Map<String, String>>[];
        
        // Parse queries to create products
        if (outfitQueries.value.isNotEmpty) {
          final queries = outfitQueries.value.split(',');
          for (var query in queries) {
            productsList.add({
              'title': query.trim(),
              'category': 'Item',
            });
          }
        }
        
        final response = await _apiService.addOutfitToFavorites(
          imageUrl: outfitImageUrl.value,
          title: 'AI Generated Outfit',
          description: outfitDescription.value,
          products: productsList,
        );
        
        if (response != null) {
          print('✅ Outfit added to favorites on server');
          print('   Response: $response');
          
          // Store outfit favorite ID from response
          if (response['favoriteOutfit'] != null && response['favoriteOutfit']['id'] != null) {
            outfitFavoriteId.value = response['favoriteOutfit']['id'].toString();
            print('📝 Stored outfit favorite ID: ${outfitFavoriteId.value}');
          } else if (response['favorite'] != null && response['favorite']['id'] != null) {
            outfitFavoriteId.value = response['favorite']['id'].toString();
            print('📝 Stored outfit favorite ID: ${outfitFavoriteId.value}');
          } else if (response['id'] != null) {
            outfitFavoriteId.value = response['id'].toString();
            print('📝 Stored outfit favorite ID: ${outfitFavoriteId.value}');
          } else {
            print('⚠️ No ID found in response');
          }
        } else {
          print('⚠️ Failed to add outfit to favorites on server');
        }
      } catch (e) {
        print('❌ Error adding outfit to favorites: $e');
      }
    } else {
      // Removing from favorites
      print('➖ Removing outfit from favorites...');
      print('   Outfit favorite ID: ${outfitFavoriteId.value}');
      
      if (outfitFavoriteId.value.isNotEmpty) {
        try {
          final success = await _apiService.removeOutfitFromFavorites(
            outfitFavoriteId: outfitFavoriteId.value,
          );
          
          if (success) {
            print('✅ Cleared outfit favorite ID');
            outfitFavoriteId.value = '';
          } else {
            print('⚠️ Delete failed, keeping ID');
          }
        } catch (e) {
          print('❌ Error removing outfit from favorites: $e');
        }
      } else {
        print('⚠️ No outfit favorite ID to delete');
      }
    }
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

  // Share outfit
  Future<void> shareOutfit() async {
    try {
      final title = 'AI Generated Outfit'.tr;
      final description = outfitDescription.value.isNotEmpty 
          ? outfitDescription.value 
          : 'Check out this amazing outfit!'.tr;
      final imageUrl = outfitImageUrl.value;

      // Create share text
      final shareText = '''
$title

$description

${imageUrl.isNotEmpty ? imageUrl : ''}
''';

      print('📤 Sharing outfit...');
      print('   Text: $shareText');

      await Share.share(
        shareText,
        subject: title,
      );

      print('✅ Share dialog opened');
    } catch (e) {
      print('❌ Error sharing outfit: $e');
      Get.snackbar(
        'Error'.tr,
        'Failed to share outfit'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
