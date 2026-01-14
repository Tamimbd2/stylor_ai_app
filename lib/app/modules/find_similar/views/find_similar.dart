import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../service/apiservice.dart';
import '../../../models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/find_similar_controller.dart';

class FindSimilarView extends GetView<FindSimilarController> {
  const FindSimilarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE8E8E8)),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Similar Products'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF1C1C1E),
                        fontSize: 24.sp,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // Content
            Expanded(
              child: Obx(() {
                // Show skeleton while loading
                if (controller.isLoading.value) {
                  return Skeletonizer(
                    enabled: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          // Skeleton chips
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: Container(
                                      height: 40.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Skeleton product cards
                          ...List.generate(
                            3,
                            (index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                              child: Container(
                                height: 156.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (controller.allProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 80.sp, color: Colors.grey[300]),
                        SizedBox(height: 16.h),
                        Text(
                          'No similar products found'.tr,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      
                      // Category Chips
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildChip('All', controller.selectedChip.value == 'All'),
                                SizedBox(width: 8.w),
                                _buildChip('Top', controller.selectedChip.value == 'Top'),
                                SizedBox(width: 8.w),
                                _buildChip('bottoms', controller.selectedChip.value == 'bottoms'),
                                SizedBox(width: 8.w),
                                _buildChip('Sunglass', controller.selectedChip.value == 'Sunglass'),
                                SizedBox(width: 8.w),
                                _buildChip('Bag', controller.selectedChip.value == 'Bag'),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Products List (using filtered products)
                      ...controller.filteredProducts.asMap().entries.map((entry) {
                        final index = entry.key;
                        final product = entry.value;
                        return _buildProductCard(product, index);
                      }),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModel product, int index) {
    final cartController = Get.find<CartController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Container(
        height: 156.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
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
            // Product Image
            Container(
              width: 134.w,
              height: 132.h,
              margin: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFF4F4F4)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                        ? Image.network(
                            product.imageUrl!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          )
                        : const Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
                  // Favorite Icon
                  Positioned(
                    left: 12.w,
                    top: 12.h,
                    child: Obx(() => GestureDetector(
                          onTap: () => controller.toggleProductFavorite(index),
                          child: Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              controller.favoriteProducts.contains(index)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18.sp,
                              color: controller.favoriteProducts.contains(index)
                                  ? Colors.red
                                  : const Color(0xFF1C1C1E),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 12.h, right: 12.w, bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        color: const Color(0xFF1C1C1E),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.56,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                    Row(
                      children: [
                        // Buy Now Button
                        GestureDetector(
                          onTap: () async {
                            final productUrl = product.productUrl ?? 'https://www.example.com/product';
                            final Uri url = Uri.parse(productUrl);

                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Container(
                            height: 36.h,
                            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF060017),
                              borderRadius: BorderRadius.circular(10.r),
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
                        SizedBox(width: 8.w),
                        // Cart Icon
                        GestureDetector(
                          onTap: () async {
                            try {
                              final apiService = Get.find<ApiService>();
                              final response = await apiService.addToCart(
                                title: product.name,
                                price: '\$${product.price.toStringAsFixed(2)}',
                                buyNowUrl: product.productUrl ?? '',
                                imageUrl: product.imageUrl ?? '',
                              );

                              if (response != null) {
                                await cartController.fetchCartItems();
                                Get.snackbar(
                                  'Added to Cart',
                                  product.name,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            } catch (e) {
                              print('❌ Failed to add to cart: $e');
                            }
                          },
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 20.sp,
                              color: const Color(0xFF1C1C1E),
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

  Widget _buildChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectChip(label),
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF060017) : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
          ),
        ),
        child: Center(
          child: Text(
            label.tr,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
              fontSize: 14.sp,
              fontFamily: 'Helvetica Neue',
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
