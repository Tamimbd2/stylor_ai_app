import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../../wardrobe/controllers/wardrobe_controller.dart';
import '../controllers/wardrop_details_controller.dart';

class WardropDetailsView extends GetView<WardropDetailsController> {
  const WardropDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Map<String, dynamic>?;
    final wardrobeController = Get.find<WardrobeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Details',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32.h),

            /// MAIN CARD
            Center(
              child: Container(
                width: 390.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0F101828),
                      blurRadius: 64,
                      offset: Offset(0, 32),
                      spreadRadius: -12,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),

                    /// 🔥 SWIPEABLE IMAGE
                    SizedBox(
                      height: 170 .h,
                      width: 170.w,
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.colorVariants.length,
                        onPageChanged: controller.onPageChanged,
                        itemBuilder: (context, index) {
                          final item = controller.colorVariants[index];
                          final imagePath = item['image'] as String;
                          final isAsset = item['isAsset'] as bool? ?? true;

                          return isAsset
                              ? Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                )
                              : (imagePath.startsWith('http')
                                  ? Image.network(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(child: CircularProgressIndicator());
                                      },
                                    )
                                  : Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                    ));
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// COLOR DOTS
                    Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller.colorVariants
                            .asMap()
                            .entries
                            .map(
                              (entry) => GestureDetector(
                            onTap: () =>
                                controller.selectColor(entry.key),
                            child: Container(
                              margin: EdgeInsets.only(right: 8.w),
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: Color(entry.value['color']),
                                shape: BoxShape.circle,
                                border:
                                controller.selectedColorIndex.value ==
                                    entry.key
                                    ? Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )
                                    : null,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),

                    SizedBox(height: 26.h),

                    /// CATEGORY
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        product?['category'] ?? 'Top',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// TITLE
                    Text(
                      product?['name'] ?? 'Vintage-style midi dress',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    /// DESCRIPTION
                    Text(
                      'perhaps a light denim blue',
                      style: TextStyle(fontSize: 14.sp),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),

            /// باقي সব আগের মতোই আছে
            /// (Wardrobe items, purchase list, etc.)
            // Item Your Wardrobe Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Item your  wardrobe',
                style: TextStyle(
                  color: const Color(0xFF1C1C1E),
                  fontSize: 20.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Wardrobe Items Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                      () => Row(
                    children: [
                      ...wardrobeController.wardrobeItems.asMap().entries.map(
                            (entry) => Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: _buildWardrobeItem(entry.value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            // Relevant To Purchase Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Relevant To parchase',
                style: TextStyle(
                  color: const Color(0xFF1C1C1E),
                  fontSize: 20.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Purchase Items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildPurchaseItem(
                    'assets/svg/dressFemale.svg',
                    'ONLMADISON High waist Wide Leg Fit Jeans',
                    '\$20.50',
                    isFavorited: true,
                  ),
                  SizedBox(height: 16.h),
                  _buildPurchaseItem(
                    'assets/svg/dresswithbg.svg',
                    'ONLMADISON High waist Wide Leg Fit Jeans',
                    '\$20.50',
                    isFavorited: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}



Widget _buildWardrobeItem(Map<String, dynamic> item) {
  final imagePath = item['image'] as String? ?? '';
  final isAsset = item['isAsset'] as bool? ?? true;
  final fit = item['fit'] as BoxFit? ?? BoxFit.contain;

  return Container(
    width: 112.w,
    height: 126.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0x0F101828),
          blurRadius: 64,
          offset: const Offset(0, 32),
          spreadRadius: -12,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Center(
        child: isAsset
            ? Image.asset(
          imagePath,
          height: 80.h,
          width: 60.w,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[100],
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey[400],
                  size: 40.sp,
                ),
              ),
            );
          },
        )
            : Image.file(
          File(imagePath),
          height: 80.h,
          width: 60.w,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[100],
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey[400],
                  size: 40.sp,
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

Widget _buildPurchaseItem(
    String imagePath,
    String title,
    String price, {
      required bool isFavorited,
    }) {
  return Container(
    height: 156.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: const Color(0xFFF4F4F4)),
      boxShadow: [
        BoxShadow(
          color: const Color(0x0F101828),
          blurRadius: 64,
          offset: const Offset(0, 32),
          spreadRadius: -12,
        ),
      ],
    ),
    child: Stack(
      children: [
        // Left Image Container
        Positioned(
          left: 12.w,
          top: 12.h,
          child: Container(
            width: 134.w,
            height: 132.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFFF4F4F4)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[100],
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey[400],
                          size: 40.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        // Heart Icon
        Positioned(
          left: 24.w,
          top: 24.h,
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_outline,
              color: isFavorited ? Colors.red : Colors.grey[400],
              size: 20.sp,
            ),
          ),
        ),
        // Product Details
        Positioned(
          left: 163.w,
          top: 12.h,
          right: 12.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 205.w,
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF1C1C1E),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.56,
                  ),
                ),
              ),

              Text(
                price,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontFamily: 'Helvetica Neue',
                  fontWeight: FontWeight.w500,
                ),
              ),

              Row(
                children: [
                  Container(
                    height: 32.h,
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
                        'Buy Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 20.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

