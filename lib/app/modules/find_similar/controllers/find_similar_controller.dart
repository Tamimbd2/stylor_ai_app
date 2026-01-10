import 'package:get/get.dart';
import '../../../../service/apiservice.dart';
import '../../../models/product_model.dart';

class FindSimilarController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  // Outfit data
  final outfitImageUrl = ''.obs;
  final outfitDescription = ''.obs;
  final outfitQueries = ''.obs;

  // Products from API
  final allProducts = <ProductModel>[].obs;
  final isLoading = false.obs;

  // Category filtering
  final selectedChip = 'All'.obs;

  // Favorite products
  final favoriteProducts = <int>{}.obs;

  // Filtered products based on selected chip
  List<ProductModel> get filteredProducts {
    if (selectedChip.value == 'All') {
      return allProducts;
    }
    return allProducts
        .where((product) => product.category == selectedChip.value)
        .toList();
  }

  // Select chip/category
  void selectChip(String chipLabel) {
    selectedChip.value = chipLabel;
  }

  @override
  void onInit() {
    super.onInit();
  }

  // Receive outfit data and search products
  void setOutfitData({
    required String imageUrl,
    required String description,
    required String queries,
  }) {
    outfitImageUrl.value = imageUrl;
    outfitDescription.value = description;
    outfitQueries.value = queries;

    print('📦 Received outfit data:');
    print('   Image: $imageUrl');
    print('   Description: $description');
    print('   Queries: $queries');

    // Search products
    searchProducts();
  }

  // Search products based on queries
  Future<void> searchProducts() async {
    if (outfitQueries.value.isEmpty) {
      print('⚠️ No queries to search');
      return;
    }

    try {
      isLoading.value = true;
      allProducts.clear();

      print('🔍 Searching products with queries: ${outfitQueries.value}');

      final response = await _apiService.searchProducts(
        queries: outfitQueries.value,
      );

      if (response != null && response['products'] != null) {
        final productsList = response['products'] as List;
        print('📦 API returned ${productsList.length} products');

        for (var productData in productsList) {
          final product = ProductModel(
            id: productData['product_url']?.toString() ?? '',
            name: productData['product_name'] ?? 'Product',
            imagePath: '',
            price: _parsePrice(productData['price']),
            category: _detectCategory(productData['product_name'] ?? ''),
            imageUrl: productData['image_url'],
            productUrl: productData['product_url'],
          );

          allProducts.add(product);
        }

        print('✅ Loaded ${allProducts.length} products');
      }
    } catch (e) {
      print('❌ Error searching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Parse price from string
  double _parsePrice(dynamic price) {
    if (price == null) return 0.0;

    final priceStr = price.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(priceStr) ?? 0.0;
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
        nameLower.contains('skirt') ||
        nameLower.contains('shoe') ||
        nameLower.contains('sneaker') ||
        nameLower.contains('boot') ||
        nameLower.contains('sandal') ||
        nameLower.contains('footwear') ||
        nameLower.contains('loafer')) {
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

    return 'Top'; // Default
  }

  void toggleProductFavorite(int index) {
    if (favoriteProducts.contains(index)) {
      favoriteProducts.remove(index);
    } else {
      favoriteProducts.add(index);
    }
  }
}
