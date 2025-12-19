import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/color.dart';
import '../../EditProfile/views/edit_profile_view.dart';

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    /// Profile Image with Verified Tick
                    Stack(
                      children: [
                        Container(
                          width: 120.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
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
                          bottom: 5,
                          right: 12,
                          child: Image.asset(
                            'assets/icons/Verified tick.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 16.w),

                    /// Name + Button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sara Rahman',
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
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileView()));
                              },
                              icon: Image.asset(
                                'assets/icons/edit-05.png',
                                width: 16.w,
                                height: 16.h,
                              ),
                              label: const Text('Edit Profile'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
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

              SizedBox(height: 20.h),

              /// ======================
              /// Switch Account
              /// ======================
              _listTileCard(
                iconPath: 'assets/icons/switchAccount.png',
                title: 'Switch Account',
                hasTrailing: true,
              ),

              SizedBox(height: 20.h),

              /// ======================
              /// User Information
              /// ======================
              Container(
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.email_outlined,
                      text: 'Example@gmail.com',
                    ),
                    Divider(height: 1, color: AppColors.neutral100),
                    _InfoRow(
                      icon: Icons.calendar_month_outlined,
                      text: '22 / 04 / 2000',
                    ),
                    Divider(height: 1, color: AppColors.neutral100),
                    _InfoRow(iconPath: 'assets/icons/males.png', text: 'Female'),
                  ],
                ),
              ),

              SizedBox(height: 250.h),

              /// ======================
              /// Delete Button
              /// ======================
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        title: Text(
                          'Delete Account',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutral900,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to delete your account? This action cannot be undone.',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.neutral600,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral600,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Delete account logic here
                              Get.back();
                              Get.snackbar(
                                'Account Deleted',
                                'Your account has been successfully deleted',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(0xFFFF3232),
                                colorText: Colors.white,
                                margin: EdgeInsets.all(16.w),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF3232),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF3232)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: const Color(0xFFFF3232),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  /// ======================
  /// Reusable Card Style
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

  /// ======================
  /// Switch Account Tile
  /// ======================
  Widget _listTileCard({
    required String iconPath,
    required String title,
    bool hasTrailing = false,
  }) {
    return Container(
      decoration: _cardDecoration(),
      child: ListTile(
        leading: Image.asset(iconPath, width: 20.w, height: 20.h),
        title: Text(
          title,
          style: TextStyle(fontSize: 14.sp, color: AppColors.neutral700),
        ),
        trailing: hasTrailing
            ? Icon(
                Icons.chevron_right,
                color: AppColors.neutral700,
                size: 20.sp,
              )
            : null,
      ),
    );
  }
}

/// ======================
/// Info Row Widget
/// ======================
class _InfoRow extends StatelessWidget {
  final IconData? icon;
  final String text;
  final String? iconPath;

  const _InfoRow({this.icon, required this.text, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: iconPath != null
          ? Image.asset(iconPath!, width: 20.w, height: 20.h)
          : Icon(icon, color: AppColors.neutral700, size: 20.sp),
      title: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: AppColors.neutral700),
      ),
    );
  }
}
