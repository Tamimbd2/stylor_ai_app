import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/color.dart';
import '../../takePhoto/views/take_photo_view.dart';
import '../controllers/wardrobe_controller.dart';
import '../../../widgets/fairy_effect_widget.dart';

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
              'Wardrobe'.tr,
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
                'Your Choices Shape AI Feed'.tr,
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
                      'All'.tr,
                      controller.selectedFilter.value == 'All',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Top'.tr,
                      controller.selectedFilter.value == 'Top',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Bottoms'.tr,
                      controller.selectedFilter.value == 'bottoms',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Sunglass'.tr,
                      controller.selectedFilter.value == 'Sunglass',
                    ),
                    SizedBox(width: 8.w),
                    _buildFilterChip(
                      'Bag'.tr,
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
                  if (controller.isAnalyzing.value &&
                      controller.analyzingImage.value != null) {
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
                              FairyEffectWidget(
                                child: Container(
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
                          child: _buildItemsGrid(),
                        ),
                      ],
                    );
                  }

                  // Show loading skeleton
                  if (controller.isLoading.value) {
                    return Skeletonizer(
                      enabled: true,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 119.0 / 126.0,
                        ),
                        itemCount: 9, // Show 9 skeleton items
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.background,
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  // Show empty state
                  if (controller.wardrobeItems.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checkroom_outlined,
                            size: 80.sp,
                            color: AppColors.neutral300,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Your wardrobe is empty',
                            style: TextStyle(
                              color: AppColors.neutral900,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Add your first outfit to get started',
                            style: TextStyle(
                              color: AppColors.neutral700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Show normal grid with pull-to-refresh
                  return RefreshIndicator(
                    onRefresh: controller.refreshWardrobe,
                    color: AppColors.primaryDark,
                    child: _buildItemsGrid(),
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
                        'Add Item'.tr,
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

  Widget _buildItemsGrid() {
    return Obx(() {
      final items = controller.filteredItems;
      
      if (items.isEmpty && controller.selectedFilter.value != 'All') {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.filter_list_off,
                size: 60.sp,
                color: AppColors.neutral300,
              ),
              SizedBox(height: 16.h),
              Text(
                'No items in ${controller.selectedFilter.value}',
                style: TextStyle(
                  color: AppColors.neutral700,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }
      
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 119.0 / 126.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              // Pass the item with ID for API fetching
              Get.toNamed(
                '/wardrop-details',
                arguments: {
                  'id': item['id'], // For API fetching
                  ...item, // Keep all other data for backward compatibility
                },
              );
            },
            child: _buildWardrobeItem(
              item,
            ),
          );
        },
      );
    });
  }

  Widget _buildWardrobeItem(Map<String, dynamic> item) {
    final isAsset = item['isAsset'] as bool? ?? true;
    final imagePath = item['image'] as String;
    final fit = item['fit'] as BoxFit? ?? BoxFit.cover;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
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
                        Icons.broken_image,
                        size: 40.sp,
                        color: AppColors.neutral300,
                      );
                    },
                  )
                : (imagePath.startsWith('http')
                    ? Image.network(
                        imagePath,
                        fit: fit,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Skeletonizer(
                            enabled: true,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 40.sp,
                            color: AppColors.neutral300,
                          );
                        },
                      )
                    : Image.file(
                        File(imagePath),
                        fit: fit,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 40.sp,
                            color: AppColors.neutral300,
                          );
                        },
                      )),
          ),
        ),
      ),
    );
  }
}
