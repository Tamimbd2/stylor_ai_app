import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routes/app_pages.dart';
import '../../../models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../favorite/controllers/favorite_controller.dart';
import '../controllers/output_outfit_controller.dart';

class OutputOutfitView extends GetView<OutputOutfitController> {
  OutputOutfitView({super.key});
  final OutputOutfitController controller = Get.put(OutputOutfitController());
  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Header
              const Center(
                child: Text(
                  'Today\'s outfits',
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 24,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Center(
                child: Text(
                  'Your choices shape your AI style feed.',
                  style: TextStyle(
                    color: Color(0xFF101C2C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Featured Outfit Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF4F4F4)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0F101828),
                        blurRadius: 64,
                        offset: Offset(0, 32),
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          children: [
                            // Outfit Image
                            Center(
                              child: Image.asset(
                                'assets/image/dress.png',
                                width: 135,
                                height: 181,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Divider(color: Color(0xFFF4F4F4)),
                            const SizedBox(height: 16),
                            // Description
                            const Text(
                              'This is really white shirt and black pant black show which show for this wither. it will match very good for this session  ',
                              style: TextStyle(
                                color: Color(0xFF49494B),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Heart Icon (top right)
                      Positioned(
                        right: 24,
                        top: 24,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleFeaturedFavorite(),
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFF4F4F4),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0F101828),
                                    blurRadius: 64,
                                    offset: Offset(0, 32),
                                    spreadRadius: -12,
                                  ),
                                ],
                              ),
                              child: Icon(
                                controller.isFeaturedOutfitFavorited.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    controller.isFeaturedOutfitFavorited.value
                                    ? Colors.red
                                    : const Color(0xFF1C1C1E),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Share Icon (middle right)
                      Positioned(
                        right: 24,
                        top: 155,
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFF4F4F4)),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0F101828),
                                blurRadius: 64,
                                offset: Offset(0, 32),
                                spreadRadius: -12,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.share_outlined,
                            color: Color(0xFF1C1C1E),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Try form section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Try form',
                  style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontSize: 20,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Category Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => Row(
                    children: [
                      _buildChip(
                        'All',
                        isSelected: controller.selectedChip.value == 'All',
                      ),
                      const SizedBox(width: 8),
                      _buildChip(
                        'Top',
                        isSelected: controller.selectedChip.value == 'Top',
                      ),
                      const SizedBox(width: 8),
                      _buildChip(
                        'bottoms',
                        isSelected: controller.selectedChip.value == 'bottoms',
                      ),
                      const SizedBox(width: 8),
                      _buildChip(
                        'Sunglass',
                        isSelected: controller.selectedChip.value == 'Sunglass',
                      ),
                      const SizedBox(width: 8),
                      _buildChip(
                        'Bag',
                        isSelected: controller.selectedChip.value == 'Bag',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Product List
              Obx(() {
                final products = controller.filteredProducts;
                if (products.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'No products in this category',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }
                
                return Column(
                  children: products.asMap().entries.map((entry) {
                    return _buildProductCard(entry.value, index: entry.key);
                  }).toList(),
                );
              }),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => controller.selectChip(label),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              height: 1.56,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product, {int index = 0}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        height: 156,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF4F4F4)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F101828),
              blurRadius: 64,
              offset: Offset(0, 32),
              spreadRadius: -12,
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image Container
            Container(
              width: 134,
              height: 132,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF4F4F4)),
              ),
              child: Stack(
                children: [
                  Center(child: Image.asset(product.imagePath, fit: BoxFit.contain)),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.toggleProductFavorite(index);
                          favoriteController.toggleFavorite(product);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.favoriteProducts.contains(index)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 14,
                            color: controller.favoriteProducts.contains(index)
                                ? Colors.red
                                : const Color(0xFF1C1C1E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: Color(0xFF1C1C1E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.56,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // Open product URL in browser
                            final Uri url = Uri.parse('https://www.example.com/product');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 36,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF060017),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Helvetica Neue',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Add to cart
                            cartController.addToCart(product);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 20,
                              color: Color(0xFF1C1C1E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
