import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/product_model.dart';
import '../../../../service/apiservice.dart';

class WardropDetailsController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  
  final count = 0.obs;
  final isLoading = false.obs;
  final isLoadingProducts = false.obs;

  /// Selected color / image index
  final selectedColorIndex = 0.obs;

  /// PageController for swipe (PageView)
  late final PageController pageController;

  /// Item details from API
  final itemDetails = Rx<Map<String, dynamic>?>(null);

  /// Color variants (image + color) - will hold both flat-lay and uploaded images
  final colorVariants = <Map<String, dynamic>>[].obs;

  /// Products
  final allProducts = <ProductModel>[].obs;
  final favoriteProducts = <int>[].obs;
  final favoriteIds = <int, String>{}.obs;

  /// Called when color dot is tapped
  void selectColor(int index) {
    if (index < colorVariants.length) {
      selectedColorIndex.value = index;

      /// Sync PageView
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Called when user swipes image
  void onPageChanged(int index) {
    if (index < colorVariants.length) {
      selectedColorIndex.value = index;
    }
  }

  /// Fetch item details from API
  Future<void> fetchItemDetails(int itemId) async {
    try {
      isLoading.value = true;
      print('📦 Fetching wardrobe item details for ID: $itemId');
      
      final details = await _apiService.getWardrobeItemDetails(itemId);
      
      if (details != null) {
        itemDetails.value = details;
        
        // Clear existing variants
        colorVariants.clear();
        
        // Add flat-lay image (generated image) as first variant
        if (details['imageUrl'] != null) {
          colorVariants.add({
            'color': 0xFF000000, // Black dot
            'image': details['imageUrl'],
            'isAsset': false,
            'label': 'Flat-Lay',
          });
        }
        
        // Add uploaded/original image as second variant
        if (details['uploadedImageUrl'] != null) {
          colorVariants.add({
            'color': 0xFFCCCCCC, // Gray dot
            'image': details['uploadedImageUrl'],
            'isAsset': false,
            'label': 'Original',
          });
        }
        
        print('✅ Loaded ${colorVariants.length} image variants');
        
        // Search for related products
        await searchProducts();
      } else {
        print('❌ Failed to fetch item details');
        Get.snackbar(
          'Error',
          'Failed to load item details',
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('❌ Error fetching item details: $e');
      Get.snackbar(
        'Error',
        'An error occurred while loading item details',
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Search for related products
  Future<void> searchProducts() async {
    try {
      isLoadingProducts.value = true;
      allProducts.clear();

      // Get search query from item description
      final description = itemDetails.value?['description'] ?? '';
      final title = itemDetails.value?['title'] ?? '';
      
      // Combine title and description for better search
      final searchQuery = '$title, $description';
      
      print('🔍 Searching products with query: $searchQuery');

      final response = await _apiService.searchProducts(
        queries: searchQuery,
        limit: 10,
        offset: 0,
      );

      if (response != null && response['products'] != null) {
        final productsList = response['products'] as List;
        print('✅ Found ${productsList.length} products');

        for (var i = 0; i < productsList.length; i++) {
          try {
            final productData = productsList[i];
            
            final product = ProductModel(
              id: productData['product_url']?.toString() ?? '',
              name: productData['product_name'] ?? 'Product',
              imagePath: '',
              price: _parsePriceToDouble(productData['price']),
              category: _detectCategory(productData['product_name'] ?? ''),
              imageUrl: productData['image_url'],
              productUrl: productData['product_url'],
            );

            allProducts.add(product);
          } catch (e) {
            print('❌ Error parsing product $i: $e');
          }
        }
        
        print('📦 Successfully loaded ${allProducts.length} products');
      }
    } catch (e) {
      print('❌ Error searching products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  /// Parse price from string to double
  double _parsePriceToDouble(dynamic price) {
    if (price == null) return 0.0;
    final priceStr = price.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(priceStr) ?? 0.0;
  }

  /// Parse price from string (for display)
  String _parsePrice(dynamic price) {
    if (price == null) return '0.00';
    final priceStr = price.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return priceStr.isEmpty ? '0.00' : priceStr;
  }

  /// Detect category from product name
  String _detectCategory(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('dress')) return 'Dress';
    if (lowerName.contains('shirt') || lowerName.contains('top') || lowerName.contains('blouse')) return 'Top';
    if (lowerName.contains('pant') || lowerName.contains('jean') || lowerName.contains('trouser')) return 'Bottoms';
    if (lowerName.contains('shoe') || lowerName.contains('sneaker') || lowerName.contains('boot')) return 'Shoes';
    if (lowerName.contains('bag') || lowerName.contains('purse')) return 'Bag';
    return 'Other';
  }

  /// Toggle product favorite
  Future<void> toggleProductFavorite(int index) async {
    final isCurrentlyFavorited = favoriteProducts.contains(index);
    
    if (isCurrentlyFavorited) {
      favoriteProducts.remove(index);
      print('💔 Removed from favorites (index: $index)');
      
      if (favoriteIds.containsKey(index)) {
        final favoriteId = favoriteIds[index]!;
        await _apiService.removeFromFavorites(favoriteId: favoriteId);
        favoriteIds.remove(index);
      }
    } else {
      favoriteProducts.add(index);
      
      if (index < allProducts.length) {
        final product = allProducts[index];
        print('❤️ Adding to favorites: ${product.name}');
        
        try {
          final response = await _apiService.addToFavorites(
            productName: product.name,
            productUrl: product.productUrl ?? '',
            imageUrl: product.imageUrl ?? '',
            price: '\$${product.price}',
            searchQuery: itemDetails.value?['description'] ?? '',
          );
          
          if (response != null && response['favorite'] != null) {
            final favoriteId = response['favorite']['id'].toString();
            favoriteIds[index] = favoriteId;
            print('✅ Added to favorites with ID: $favoriteId');
          }
        } catch (e) {
          print('❌ Error adding to favorites: $e');
        }
      }
    }
  }

  /// Add to cart
  Future<void> addToCart(int index) async {
    if (index < allProducts.length) {
      final product = allProducts[index];
      print('🛒 Adding to cart: ${product.name}');
      
      try {
        final response = await _apiService.addToCart(
          title: product.name,
          price: '\$${product.price.toStringAsFixed(2)}',
          buyNowUrl: product.productUrl ?? '',
          imageUrl: product.imageUrl ?? '',
        );
        
        if (response != null) {
          Get.snackbar(
            'Success',
            'Added to cart!',
            backgroundColor: Colors.black,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      } catch (e) {
        print('❌ Error adding to cart: $e');
      }
    }
  }

  /// Buy now - open product URL
  Future<void> buyNow(int index) async {
    if (index < allProducts.length) {
      final product = allProducts[index];
      final url = product.productUrl;
      
      if (url != null && url.isNotEmpty) {
        print('🛍️ Opening product URL: $url');
        
        try {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            Get.snackbar(
              'Error',
              'Could not open product link',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } catch (e) {
          print('❌ Error launching URL: $e');
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedColorIndex.value);

    // Get arguments
    final args = Get.arguments as Map<String, dynamic>?;
    
    if (args != null) {
      // Check if we have an item ID to fetch from API
      if (args['id'] != null) {
        final itemId = args['id'] as int;
        fetchItemDetails(itemId);
      } else {
        // Fallback to old behavior (using passed arguments directly)
        colorVariants.clear();
        
        // Add the main image (likely generated flat lay or asset)
        colorVariants.add({
          'color': 0xFF000000, 
          'image': args['image'] ?? '',
          'isAsset': args['isAsset'] ?? true,
        });

        // If there is an original captured image, add it as the second option (swipe right)
        if (args['originalImage'] != null) {
          colorVariants.add({
            'color': 0xFFCCCCCC,
            'image': args['originalImage'],
            'isAsset': false, // Captured photos are files
          });
        }
      }
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Optional counter
  void increment() => count.value++;
}
