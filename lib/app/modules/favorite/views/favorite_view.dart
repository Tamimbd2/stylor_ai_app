import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/product_model.dart';
import '../../cart/controllers/cart_controller.dart';
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
                'Favorite',
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
                'Your choices shape your AI style feed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF101C2C),
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
              SizedBox(height: 24.h),

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
                                'Product',
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
                          onTap: () => controller.isOutfitSelected.value = true,
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
                                'Outfit',
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

              SizedBox(height: 24.h),

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
              Icon(
                Icons.favorite_border,
                size: 80.sp,
                color: Colors.grey[300],
              ),
              SizedBox(height: 16.h),
              Text(
                'No favorite products yet',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Start adding products to your favorites',
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
    return Column(
      children: [
        _buildOutfitCard('assets/image/dress.png'),
        _buildOutfitCard('assets/image/manDress.png'),
        _buildOutfitCard('assets/image/dress.png'),
      ],
    );
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
                  Center(child: Image.asset(product.imagePath, fit: BoxFit.contain)),
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

  Widget _buildOutfitCard(String imagePath) {
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
                  Center(
                    child: Image.asset(
                      imagePath,
                      width: 62.w,
                      height: 83.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 12.w,
                    top: 12.h,
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
                      'This is really white shirt and black pant black show which show for this wither. it will match very good ....',
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
                    Container(
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
                          'Find Similar',
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
