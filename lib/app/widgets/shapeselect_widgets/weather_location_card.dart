import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modules/shapeselect/controllers/shapeselect_controller.dart';
import '../../../core/color.dart';

class WeatherLocationCard extends StatefulWidget {
  const WeatherLocationCard({super.key});

  @override
  State<WeatherLocationCard> createState() => _WeatherLocationCardState();
}

class _WeatherLocationCardState extends State<WeatherLocationCard> {
  late TextEditingController _tempController;
  final RxBool _isEditing = false.obs;

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
    return Container(
      width: double.infinity,
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: AppColors.neutral100),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
        SvgPicture.asset(
        'assets/svg/temp.svg',
        width: 24,
        height: 20,
        fit: BoxFit.contain,
      ),
          SizedBox(width: 6.w),
          Obx(
            () => _isEditing.value
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
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(
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
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            color: AppColors.neutral200,
          ),
          SvgPicture.asset(
            'assets/svg/location.svg',
            width: 24,
            height: 20,
            fit: BoxFit.contain,
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
                if (_isEditing.value) {
                  _isEditing.value = false;
                  // Update controller
                  final tempString = _tempController.text;
                  // Extract number from string if possible, or just parse directly
                  // Assuming user enters just a number or we parse it.
                  // For simplicity, let's try to parse the first number found
                  final RegExp regExp = RegExp(r'(\d+(\.\d+)?)');
                  final match = regExp.firstMatch(tempString);
                  if (match != null) {
                     final val = double.tryParse(match.group(0)!);
                     if (val != null) {
                       Get.find<ShapeselectController>().updateTemperature(val);
                     }
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Temperature updated!'),
                      backgroundColor: AppColors.primaryDark,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                } else {
                  _isEditing.value = true;
                }
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isEditing.value
                      ? AppColors.primaryDark
                      : Colors.transparent,
                ),
                child: SvgPicture.asset(
                  _isEditing.value
                      ? 'assets/svg/saved.svg'
                      : 'assets/svg/edit.svg',
                  width: 14.w,
                  height: 14.h,
                  colorFilter: ColorFilter.mode(
                    _isEditing.value ? Colors.white : AppColors.neutral700,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconImage extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;

  const IconImage(this.assetPath, {super.key, this.width = 18, this.height = 18});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width.w,
      height: height.h,
      color: AppColors.neutral700,
    );
  }
}
