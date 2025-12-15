import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 24.h),

              /// ======================
              /// Profile Card
              /// ======================
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    /// Profile Image + Verified Tick
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3.w),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19101828),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/image/profilef.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Image.asset(
                            'assets/icons/Verified tick.png',
                            width: 24.w,
                            height: 24.w,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 16.w),

                    /// Name + Edit Button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mohammad Ali',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutral900,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            height: 28.h,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/icons/edit-05.png',
                                width: 16.w,
                                height: 16.w,
                              ),
                              label: Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r),
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
            ],
          ),
        ),
      ),
    );
  }

  /// ======================
  /// Card Decoration
  /// ======================
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0F101828),
          blurRadius: 64,
          offset: Offset(0, 32),
          spreadRadius: -12,
        ),
      ],
    );
  }
}
