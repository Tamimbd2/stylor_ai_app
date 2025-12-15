import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color.dart';
import '../../output_outfit/views/output_outfit_view.dart';
import '../controllers/shapeselect_controller.dart';

class ShapeselectView extends GetView<ShapeselectController> {
  ShapeselectView({super.key});
  final ShapeselectController controller = Get.put(ShapeselectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(
          () => controller.showOutfitDetails.value
              ? OutputOutfitView()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          children: [
                            // Title
                            Text(
                              'Today\'s outfits',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.neutral900,
                                fontSize: 24.sp,
                                fontFamily: 'Helvetica Neue',
                                fontWeight: FontWeight.w700,
                                height: 1.40,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Subtitle
                            Text(
                              'Your choices shape your AI style feed.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.neutral900,
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.56,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            // Weather and Location Info
                            Container(
                              width: double.infinity,
                              height: 44.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.neutral100,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/temperature.png',
                                    width: 18.w,
                                    height: 18.h,
                                    color: AppColors.neutral700,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    '30.5 °C (87°F)',
                                    style: TextStyle(
                                      color: AppColors.neutral700,
                                      fontSize: 13.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 18.h,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    color: AppColors.neutral200,
                                  ),
                                  Image.asset(
                                    'assets/icons/location.png',
                                    width: 18.w,
                                    height: 18.h,
                                    color: AppColors.neutral700,
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      'Brussels, Belgium',
                                      style: TextStyle(
                                        color: AppColors.neutral700,
                                        fontSize: 13.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/edit.png',
                                    width: 14.w,
                                    height: 14.h,
                                    color: AppColors.neutral700,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Outfit Card Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        child: Stack(
                          children: [
                            // Main Outfit Card
                            Center(
                              child: Container(
                                width: 335.w,
                                height: 375.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.neutral50,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x0F101828),
                                      blurRadius: 64,
                                      offset: Offset(0, 32),
                                      spreadRadius: -12,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/image/dress.png',
                                      width: 210.w,
                                      height: 290.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Share Button (bottom right of card with arrow)
                            Positioned(
                              right: 12.w,
                              bottom: 12.h,
                              child: GestureDetector(
                                onTap: () {
                                  controller.toggleOutfitDetails();
                                },
                                child: Container(
                                  width: 48.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.neutral50,
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
                                  child: Image.asset(
                                    'assets/icons/arrow.png',
                                    width: 20.w,
                                    height: 20.h,
                                    color: AppColors.neutral900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action Buttons (Dislike and Like)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.neutral50,
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
                                Icons.close,
                                size: 20.sp,
                                color: AppColors.neutral900,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              width: 48.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.neutral50,
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
                              child: const Icon(
                                Icons.favorite,
                                size: 20,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Style Selector Dropdown
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        child: GestureDetector(
                          onTap: () => _showStyleSelector(context),
                          child: Container(
                            width: double.infinity,
                            height: 44.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 1,
                                color: AppColors.neutral100,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/casual.png',
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    'Casual',
                                    style: TextStyle(
                                      color: AppColors.neutral700,
                                      fontSize: 13.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 14.sp,
                                  color: AppColors.neutral700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
        ),
      ),

      // Bottom Navigation Bar
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 22.sp,
          color: isActive ? AppColors.primaryDark : AppColors.neutral500,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primaryDark : AppColors.neutral500,
            fontSize: 12.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  void _showStyleSelector(BuildContext context) {
    final styles = [
      {'label': 'Casual', 'icon': 'assets/icons/casual.png'},
      {'label': 'Formal', 'icon': 'assets/icons/formal.png'},
      {'label': 'Streetwear', 'icon': 'assets/icons/Streetwear.png'},
      {'label': 'Minimalist', 'icon': 'assets/icons/Minimalist.png'},
      {'label': 'Party', 'icon': 'assets/icons/Party.png'},
      {'label': 'Artistic', 'icon': 'assets/icons/Artistic.png'},
      {'label': 'Vintage', 'icon': 'assets/icons/Vintage.png'},
      {'label': 'Sporty', 'icon': 'assets/icons/Sporty.png'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Style',
                  style: TextStyle(
                    color: AppColors.neutral900,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: styles.length,
                  itemBuilder: (context, index) {
                    final style = styles[index];
                    return GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          children: [
                            Image.asset(
                              style['icon'] as String,
                              width: 32.w,
                              height: 32.h,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              style['label'] as String,
                              style: TextStyle(
                                color: AppColors.neutral700,
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
