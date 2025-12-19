import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              SizedBox(height: 24.h),
              // Header
              Center(
                child: Text(
                  'Today\'s outfits',
                  style: TextStyle(
                    color: const Color(0xFF1C1C1E),
                    fontSize: 24.sp,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Center(
                child: Text(
                  'Your choices shape your AI style feed.',
                  style: TextStyle(
                    color: const Color(0xFF101C2C),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                ),
              ),
              SizedBox(height: 40.h),

              // Featured Outfit Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.w),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
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
                        padding: EdgeInsets.all(26.w),
                        child: Column(
                          children: [
                            // Outfit Image
                            Center(
                              child: Image.asset(
                                'assets/image/dress.png',
                                width: 135.w,
                                height: 181.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            const Divider(color: Color(0xFFF4F4F4)),
                            SizedBox(height: 16.h),
                            // Description
                            Text(
                              'This is really white shirt and black pant black show which show for this wither. it will match very good for this session  ',
                              style: TextStyle(
                                color: const Color(0xFF49494B),
                                fontSize: 14.sp,
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
                        right: 24.w,
                        top: 24.h,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleFeaturedFavorite(),
                            child: Container(
                              width: 56.w,
                              height: 56.h,
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
                                size: 24.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Share Icon (middle right)
                      Positioned(
                        right: 24.w,
                        top: 155.h,
                        child: Container(
                          width: 56.w,
                          height: 56.h,
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
                          child: Icon(
                            Icons.share_outlined,
                            color: const Color(0xFF1C1C1E),
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Try form section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Try form',
                  style: TextStyle(
                    color: const Color(0xFF1C1C1E),
                    fontSize: 20.sp,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Category Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(
                  () => Row(
                    children: [
                      _buildChip(
                        'All',
                        isSelected: controller.selectedChip.value == 'All',
                      ),
                      SizedBox(width: 8.w),
                      _buildChip(
                        'Top',
                        isSelected: controller.selectedChip.value == 'Top',
                      ),
                      SizedBox(width: 8.w),
                      _buildChip(
                        'bottoms',
                        isSelected: controller.selectedChip.value == 'bottoms',
                      ),
                      SizedBox(width: 8.w),
                      _buildChip(
                        'Sunglass',
                        isSelected: controller.selectedChip.value == 'Sunglass',
                      ),
                      SizedBox(width: 8.w),
                      _buildChip(
                        'Bag',
                        isSelected: controller.selectedChip.value == 'Bag',
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Product List
              Obx(() {
                final products = controller.filteredProducts;
                if (products.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: Text(
                        'No products in this category',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16.sp,
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

              SizedBox(height: 20.h),
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
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF060017) : const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF1C1C1E),
              fontSize: 14.sp,
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
            // Product Image Container
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
                  Center(child: Image.asset(product.imagePath, fit: BoxFit.contain)),
                  Positioned(
                    left: 12.w,
                    top: 12.h,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.toggleProductFavorite(index);
                          favoriteController.toggleFavorite(product);
                        },
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.favoriteProducts.contains(index)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 14.sp,
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
                        GestureDetector(
                          onTap: () async {
                            // Open product URL in browser
                            final Uri url = Uri.parse('https://www.example.com/product');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            }
                          },
                          child: Container(
                            height: 36.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 28.w,
                              vertical: 5.h,
                            ),
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
                        GestureDetector(
                          onTap: () {
                            // Add to cart
                            cartController.addToCart(product);
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
