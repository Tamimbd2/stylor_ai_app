import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../core/color.dart';
import 'weather_location_card.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          Text(
            'Todays Outfits'.tr,
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
          Text(
            'Your Choices Shape AI Feed'.tr,
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
          const WeatherLocationCard(),
        ],
      ),
    );
  }
}
