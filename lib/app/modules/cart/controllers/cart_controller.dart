import 'package:get/get.dart';
import '../../../../service/apiservice.dart';
import '../../../models/product_model.dart';


class CartController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  
  // List of products in cart
  final RxList<ProductModel> cartItems = <ProductModel>[].obs;
  final isLoading = false.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  // Fetch cart items from server
  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      cartItems.clear();

      final items = await _apiService.getCartItems();

      for (var item in items) {
        // Convert API cart item to ProductModel
        final product = ProductModel(
          id: item['id']?.toString() ?? '', // Use cart item ID, not product URL
          name: item['title'] ?? 'Product',
          imagePath: '',
          price: _parsePrice(item['price']),
          imageUrl: item['image_url'],
          productUrl: item['buy_now_url'],
        );

        cartItems.add(product);
      }

      print('📦 Loaded ${cartItems.length} items from cart');
    } catch (e) {
      print('❌ Error fetching cart items: $e');
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

  // Add product to cart
  void addToCart(ProductModel product) {
    cartItems.add(product);
    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      // margin: const EdgeInsets.all(16),
    );
  }

  // Remove product from cart
  Future<void> removeFromCart(ProductModel product) async {
    // Remove from local list immediately for instant UI feedback
    cartItems.remove(product);
    
    // Call API to remove from server
    try {
      final success = await _apiService.removeFromCart(
        cartItemId: product.id,
      );
      
      if (!success) {
        print('⚠️ Failed to remove from cart on server');
        // Optionally re-add to local list if API fails
        // cartItems.add(product);
      }
    } catch (e) {
      print('❌ Error removing from cart: $e');
    }
  }

  // Get total price
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  // Check if cart is empty
  bool get isCartEmpty => cartItems.isEmpty;
}
