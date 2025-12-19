import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color.dart';
import '../../takePhoto/views/take_photo_view.dart';
import '../controllers/wardrobe_controller.dart';

class WardrobeView extends GetView<WardrobeController> {
  WardrobeView({super.key});
  @override
  final WardrobeController controller = Get.put(WardrobeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // Title
            Text(
              'Wardrobe',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.neutral900,
                fontSize: 24.sp,
                fontFamily: 'Helvetica Neue',
                fontWeight: FontWeight.w700,
                height: 1.40,
              ),
            ),
            SizedBox(height: 16.h),
            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Your choices shape your AI style feed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.neutral900,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Filter Tabs
            SizedBox(
              height: 36.h,
              child: Obx(
                () => ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    _buildFilterChip(
                      'All',
                      controller.selectedFilter.value == 'All',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Top',
                      controller.selectedFilter.value == 'Top',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'bottoms',
                      controller.selectedFilter.value == 'bottoms',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Sunglass',
                      controller.selectedFilter.value == 'Sunglass',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Bag',
                      controller.selectedFilter.value == 'Bag',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            // Grid of items
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(() {
                  // Show analyzing UI if analyzing
                  if (controller.isAnalyzing.value && controller.analyzingImage.value != null) {
                    return Column(
                      children: [
                        // Analyzing Card
                        Container(
                          width: 358.w,
                          height: 126.h,
                          padding: EdgeInsets.all(16.w),
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
                          child: Row(
                            children: [
                              // Photo Preview
                              Container(
                                width: 94.w,
                                height: 94.h,
                                decoration: BoxDecoration(
                                  color: AppColors.neutral100,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.file(
                                  controller.analyzingImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              // Analyzing Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'AI Analyzing your photo',
                                      style: TextStyle(
                                        color: AppColors.neutral900,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        height: 1.40,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Item will be store in your wardrobe',
                                      style: TextStyle(
                                        color: AppColors.neutral700,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1.56,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Show existing items below
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                              childAspectRatio: 119.0 / 126.0,
                            ),
                            itemCount: controller.wardrobeItems.length,
                            itemBuilder: (context, index) {
                              return _buildWardrobeItem(controller.wardrobeItems[index]);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  
                  // Show normal grid
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 119.0 / 126.0,
                    ),
                    itemCount: controller.wardrobeItems.length,
                    itemBuilder: (context, index) {
                      return _buildWardrobeItem(controller.wardrobeItems[index]);
                    },
                  );
                }),
              ),
            ),
            // Add new Outfit button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TakePhotoView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Add new Outfit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontFamily: 'Helvetica Neue',
                          fontWeight: FontWeight.w700,
                          height: 1.40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectFilter(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : AppColors.neutral100,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.neutral900,
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              height: 1.56,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWardrobeItem(Map<String, dynamic> item) {
    final isAsset = item['isAsset'] as bool? ?? true;
    final imagePath = item['image'] as String;
    final fit = item['fit'] as BoxFit? ?? BoxFit.cover;

    return Container(
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
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Center(
            child: isAsset
                ? Image.asset(
                    imagePath,
                    fit: fit,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_outlined,
                        size: 40.sp,
                        color: AppColors.neutral100,
                      );
                    },
                  )
                : Image.file(
                    File(imagePath),
                    fit: fit,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_outlined,
                        size: 40.sp,
                        color: AppColors.neutral100,
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
