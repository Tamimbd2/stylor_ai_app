import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/color.dart';
import '../../language/views/language_view.dart';
import '../../privacyPolicy/views/privacy_policy_view.dart';
import '../../termsAndConditions/views/terms_and_conditions_view.dart';
import '../../ProfileDetails/views/profile_details_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                // Profile Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDetailsView(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
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
                        // Profile Image
                        Container(
                          width: 66.w,
                          height: 66.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x0F101828),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                                spreadRadius: -2,
                              ),
                              BoxShadow(
                                color: const Color(0x19101828),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/image/profile.png',
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFE8E8E8),
                                  child: Icon(
                                    Icons.person,
                                    size: 40.sp,
                                    color: AppColors.neutral700,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Name and Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mohammad Ali',
                                style: TextStyle(
                                  color: AppColors.neutral900,
                                  fontSize: 16.sp,
                                  fontFamily: 'Helvetica Neue',
                                  fontWeight: FontWeight.w700,
                                  height: 1.50,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Your account Details',
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
                        // Arrow Icon
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.neutral700,
                          size: 24.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                // Settings Title
                Text(
                  'Settings',
                  style: TextStyle(
                    color: AppColors.neutral900,
                    fontSize: 20.sp,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
                SizedBox(height: 16.h),
                // Settings Card
                Container(
                  width: double.infinity,
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
                  child: Column(
                    children: [
                      Obx(
                        () => _buildSettingItem(
                          icon: Icons.notifications_outlined,
                          title: 'Notification',
                          hasSwitch: true,
                          switchValue: controller.isNotificationEnabled.value,
                          onTap: () => controller.toggleNotification(
                            !controller.isNotificationEnabled.value,
                          ),
                        ),
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.lock_outline,
                        title: 'Privacy',
                        hasArrow: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicyView(),
                            ),
                          );
                          // Navigate to Privacy settings
                        },
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.language,
                        title: 'Language',
                        trailingText: 'English',
                        hasArrow: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguageView(),
                            ),
                          );
                          // Navigate to Language selection
                        },
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.description_outlined,
                        title: 'Terms and condition',
                        hasArrow: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsAndConditionsView(),
                            ),
                          );
                          // Navigate to Terms and condition
                        },
                      ),
                      _buildDivider(),
                      _buildSettingItem(
                        icon: Icons.share_outlined,
                        title: 'Share The app',
                        hasArrow: true,
                        onTap: () {
                          print('Share The app tapped');
                          // Share app functionality
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 300.h),
                // Log Out Button
                Container(
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.neutral100, width: 1),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 18.sp,
                        fontFamily: 'Helvetica Neue',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? trailingText,
    bool hasArrow = false,
    bool hasSwitch = false,
    bool switchValue = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: AppColors.neutral700),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                color: AppColors.neutral700,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.56,
              ),
            ),
            const Spacer(),
            if (trailingText != null)
              Text(
                trailingText,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.neutral700,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.56,
                ),
              ),
            if (hasSwitch)
              Switch(
                value: switchValue,
                onChanged: (value) {
                  onTap?.call();
                },
                activeColor: Colors.white,
                activeTrackColor: AppColors.primaryDark,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: AppColors.neutral100,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            if (hasArrow)
              Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: AppColors.neutral700,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Divider(height: 1, thickness: 1, color: AppColors.neutral100),
    );
  }
}
