import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../find_similar/views/find_similar.dart';
import '../../find_similar/controllers/find_similar_controller.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  FavoriteView({super.key});
  @override
  final FavoriteController controller = Get.put(FavoriteController());
  final CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              // Header
              Text(
                'Favorites'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF1C1C1E),
                  fontSize: 24.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                  height: 1.40,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Your Choices Shape AI Feed'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF101C2C),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
              SizedBox(height: 16.h),

              // Toggle Buttons (Product / Outfit)
              Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              controller.isOutfitSelected.value = false,
                          child: Container(
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: !controller.isOutfitSelected.value
                                  ? const Color(0xFF060017)
                                  : Colors.white,
                              border: Border.all(
                                color: const Color(0xFFE8E8E8),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                bottomLeft: Radius.circular(12.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Products'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !controller.isOutfitSelected.value
                                      ? Colors.white
                                      : const Color(0xFF1C1C1E),
                                  fontSize: 18.sp,
                                  fontFamily: 'Helvetica Neue',
                                  fontWeight: !controller.isOutfitSelected.value
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.isOutfitSelected.value = true;
                            // Refresh outfits when tab is selected
                            controller.fetchFavoriteOutfits();
                          },
                          child: Container(
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: controller.isOutfitSelected.value
                                  ? const Color(0xFF060017)
                                  : Colors.white,
                              border: Border.all(
                                color: const Color(0xFFE8E8E8),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.r),
                                bottomRight: Radius.circular(12.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Outfits'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: controller.isOutfitSelected.value
                                      ? Colors.white
                                      : const Color(0xFF1C1C1E),
                                  fontSize: 18.sp,
                                  fontFamily: 'Helvetica Neue',
                                  fontWeight: controller.isOutfitSelected.value
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Content based on selection
              Obx(
                () => controller.isOutfitSelected.value
                    ? _buildOutfitList()
                    : _buildProductList(),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return Obx(() {
      if (controller.favoriteProducts.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 80.sp, color: Colors.grey[300]),
              SizedBox(height: 16.h),
              Text(
                'No Favorite Products Yet'.tr,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Start Adding Products'.tr,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        children: controller.favoriteProducts
            .map((product) => _buildFavoriteCard(product))
            .toList(),
      );
    });
  }

  Widget _buildOutfitList() {
    return Obx(() {
      if (controller.favoriteOutfits.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 80.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.checkroom_outlined, size: 80.sp, color: Colors.grey[300]),
              SizedBox(height: 16.h),
              Text(
                'No Favorite Outfits Yet'.tr,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Start Adding Outfits'.tr,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        children: controller.favoriteOutfits
            .map((outfit) => _buildOutfitCard(outfit))
            .toList(),
      );
    });
  }

  Widget _buildFavoriteCard(ProductModel product) {
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
                  Center(
                    child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                        ? Image.network(
                            product.imageUrl!,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          )
                        : const Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                  ),
                  Positioned(
                    left: 12.w,
                    top: 12.h,
                    child: GestureDetector(
                      onTap: () => controller.removeFromFavorites(product),
                      child: Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 18.sp,
                          color: Colors.red,
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
                            final productUrl = product.productUrl ?? 'https://www.example.com/product';
                            final Uri url = Uri.parse(productUrl);
                            
                            print('❤️ Opening favorite product URL: $productUrl');
                            
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                'Could not open product link',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Container(
                            height: 36.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF060017),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
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
                          onTap: () => cartController.addToCart(product),
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

  Widget _buildOutfitCard(outfit) {
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
            // Outfit Image Container
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: outfit.imageUrl.isNotEmpty
                        ? Image.network(
                            outfit.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          )
                        : const Center(
                            child: Icon(
                              Icons.checkroom,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  Positioned(
                    left: 12.w,
                    top: 12.h,
                    child: GestureDetector(
                      onTap: () => controller.removeOutfitFromFavorites(outfit),
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Outfit Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 12.h,
                  right: 12.w,
                  bottom: 12.h,
                  left: 6.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      outfit.description,
                      style: TextStyle(
                        color: const Color(0xFF1C1C1E),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.56,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('🔍 Find Similar button tapped!');
                        
                        // Convert products to comma-separated queries
                        final productTitles = <String>[];
                        for (var p in outfit.products) {
                          final title = p['title'] ?? '';
                          if (title.isNotEmpty) {
                            productTitles.add(title);
                          }
                        }
                        final queries = productTitles.join(',');

                        print('   Queries: $queries');

                        // Initialize controller and set data
                        final controller = Get.put(FindSimilarController());
                        controller.setOutfitData(
                          imageUrl: outfit.imageUrl,
                          description: outfit.description,
                          queries: queries,
                        );

                        // Navigate to Find Similar screen
                        Get.to(const FindSimilarView());
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
                        child: Center(
                          child: Text(
                            'Find Similar'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Helvetica Neue',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ),
                      ),
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
