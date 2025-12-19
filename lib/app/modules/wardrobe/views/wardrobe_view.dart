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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 119.0 / 126.0,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _buildWardrobeItem(index);
                  },
                ),
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

  Widget _buildWardrobeItem(int index) {
    final items = [
      {'image': 'assets/image/clothes.png', 'fit': BoxFit.cover},
      {'image': 'assets/image/dress2.png', 'fit': BoxFit.cover},
      {'image': 'assets/image/shoe.png', 'fit': BoxFit.contain},
      {'image': 'assets/image/dreess1.png', 'fit': BoxFit.cover},
      {'image': 'assets/image/sunglass.png', 'fit': BoxFit.contain},
    ];

    if (index >= items.length) return const SizedBox.shrink();

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
            child: Image.asset(
              items[index]['image'] as String,
              fit: items[index]['fit'] as BoxFit,
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
