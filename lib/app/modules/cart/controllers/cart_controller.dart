import 'package:get/get.dart';
import '../../../models/product_model.dart';

class CartController extends GetxController {
  // List of products in cart
  final RxList<ProductModel> cartItems = <ProductModel>[].obs;

  final count = 0.obs;



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
  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
  }

  // Get total price
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  // Check if cart is empty
  bool get isCartEmpty => cartItems.isEmpty;
}
