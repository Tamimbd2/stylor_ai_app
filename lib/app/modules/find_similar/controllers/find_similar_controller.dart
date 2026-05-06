import 'package:get/get.dart';
import '../../../../service/apiservice.dart';
import '../../../models/product_model.dart';
import '../../../services/product_recommendation_filter_service.dart';

class FindSimilarController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  final ProductRecommendationFilterService _filterService =
      const ProductRecommendationFilterService();

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
        final productsList = (response['products'] as List)
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
        final queryTokens =
            _filterService.parseQueryTokens(outfitQueries.value);

        print('📦 API returned ${productsList.length} products');

        final rankedProducts = _filterService.rankProducts(
          rawProducts: productsList,
          queryTokens: queryTokens,
        );

        allProducts.assignAll(rankedProducts);

        print('✅ Loaded ${allProducts.length} products');
      }
    } catch (e) {
      print('❌ Error searching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleProductFavorite(int index) {
    if (favoriteProducts.contains(index)) {
      favoriteProducts.remove(index);
    } else {
      favoriteProducts.add(index);
    }
  }
}
