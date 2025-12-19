import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/color.dart';
import 'weather_location_card.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
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
          const WeatherLocationCard(),
        ],
      ),
    );
  }
}
