import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../output_outfit/views/output_outfit_view.dart';
import '../controllers/shapeselect_controller.dart';

class ShapeselectView extends StatefulWidget {
   ShapeselectView({super.key});
final ShapeselectController controller = Get.put(ShapeselectController());
final CartController cartController = Get.put(CartController());
  @override
  State<ShapeselectView> createState() => _ShapeselectViewState();
}

class _ShapeselectViewState extends State<ShapeselectView> {
  final ShapeselectController controller = Get.put(ShapeselectController());

  late TextEditingController _tempController;
  final RxBool _isEditingTemp = false.obs;
  String _selectedStyle = 'Casual Outing';

  @override
  void initState() {
    super.initState();
    _tempController = TextEditingController(text: '30.5 °C (87°F)');
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

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
                                  Obx(
                                    () => _isEditingTemp.value
                                        ? SizedBox(
                                            width: 100.w,
                                            height: 24.h,
                                            child: TextField(
                                              controller: _tempController,
                                              style: TextStyle(
                                                color: AppColors.neutral700,
                                                fontSize: 13.sp,
                                                fontFamily: 'Poppins',
                                              ),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.r,
                                                      ),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 2.h,
                                                    ),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            _tempController.text,
                                            style: TextStyle(
                                              color: AppColors.neutral700,
                                              fontSize: 13.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 1.4,
                                            ),
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
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_isEditingTemp.value) {
                                            // Save
                                            _isEditingTemp.value = false;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  'Temperature updated!',
                                                ),
                                                backgroundColor:
                                                    AppColors.primaryDark,
                                                duration: const Duration(
                                                  seconds: 1,
                                                ),
                                              ),
                                            );
                                          } else {
                                            // Edit
                                            _isEditingTemp.value = true;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _isEditingTemp.value
                                              ? AppColors.primaryDark
                                              : Colors.transparent,
                                        ),
                                        child: Image.asset(
                                          _isEditingTemp.value
                                              ? 'assets/icons/saved.png'
                                              : 'assets/icons/edit.png',
                                          width: 14.w,
                                          height: 14.h,
                                          color: _isEditingTemp.value
                                              ? Colors.white
                                              : AppColors.neutral700,
                                        ),
                                      ),
                                    ),
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
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    _selectedStyle,
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

  // Widget _buildNavItem(IconData icon, String label, bool isActive) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Icon(
  //         icon,
  //         size: 22.sp,
  //         color: isActive ? AppColors.primaryDark : AppColors.neutral500,
  //       ),
  //       SizedBox(height: 4.h),
  //       Text(
  //         label,
  //         style: TextStyle(
  //           color: isActive ? AppColors.primaryDark : AppColors.neutral500,
  //           fontSize: 12.sp,
  //           fontFamily: 'Poppins',
  //           fontWeight: FontWeight.w400,
  //           height: 1.4,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _showStyleSelector(BuildContext context) {
    final styles = [
      'Casual Outing',
      'Formal Occasion',
      'Business Meeting',
      'Date Night',
      'Wedding',
      'Workout',
      'Travel',
      'Festival',
      'Beach Day',
      'Winter Outdoor',
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
                    final isSelected = _selectedStyle == style;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStyle = style;
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.primaryDark
                                    : Colors.transparent,
                                border: Border.all(
                                  width: 2,
                                  color: isSelected
                                      ? AppColors.primaryDark
                                      : AppColors.neutral300,
                                ),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      size: 12.sp,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                style,
                                style: TextStyle(
                                  color: AppColors.neutral700,
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                ),
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
