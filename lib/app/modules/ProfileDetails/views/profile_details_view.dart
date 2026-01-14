import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/color.dart';
import '../../../../service/apiservice.dart';
import '../../../routes/app_pages.dart';
import '../../../controllers/user_controller.dart';

class ProfileDetailsView extends StatelessWidget {
  ProfileDetailsView({super.key});
  
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
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
                          width: 70.w,
                          height: 70.w,
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
                            color: const Color(0xFFF2F4F7), // Light background for fallback
                          ),
                          child: ClipOval(
                            child: Obx(() {
                                final user = userController.user.value;
                                if (user?.avatar != null && user!.avatar!.isNotEmpty) {
                                  return Image.network(
                                    user.avatar!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(),
                                  );
                                } else {
                                  return _buildFallbackIcon();
                                }
                            }),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 5,
                        //   right: 0,
                        //   child: Image.asset(
                        //     'assets/icons/Verified tick.png',
                        //     width: 24.w,
                        //     height: 24.h,
                        //   ),
                        // ),
                      ],
                    ),

                    SizedBox(width: 16.w),

                    /// Name + Button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                            userController.user.value?.name ?? 'User'.tr,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutral900,
                            ),
                          )),
                          SizedBox(height: 8.h),
                          SizedBox(
                            height: 28.h,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.toNamed(Routes.EDIT_PROFILE);
                              },
                              icon: Image.asset(
                                'assets/icons/edit-05.png',
                                width: 16.w,
                                height: 16.h,
                              ),
                              label: Text('Edit Profile'.tr),
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
                iconPath: 'assets/svg/sw.svg',
                title: 'Switch Account'.tr,
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
                    Obx(() => _InfoRow(
                      icon: Icons.email_outlined,
                      text: userController.user.value?.email ?? 'Example@gmail.com',
                    )),
                    Divider(height: 1, color: AppColors.neutral100),
                    Obx(() {
                      final bDay = userController.user.value?.birthdate;
                      String formattedDate = 'DD / MM / YYYY';
                      if (bDay != null) {
                         try {
                           final date = DateTime.parse(bDay);
                           // Format: 22 / 04 / 2000
                           // You might need to import 'package:intl/intl.dart';
                           // Since I can't see imports, I'll use manual formatting or assume intl is there.
                           // Actually, let's just show string if parse fails, or format it.
                           // Let's use basic string manipulation for safety if intl not guaranteed imported in this view, 
                           // but I should probably import intl.
                           // Or simpler:
                           formattedDate = "${date.day.toString().padLeft(2,'0')} / ${date.month.toString().padLeft(2,'0')} / ${date.year}";
                         } catch (e) {
                           formattedDate = bDay;
                         }
                      }
                      return _InfoRow(
                        icon: Icons.calendar_month_outlined,
                        text: formattedDate,
                      );
                    }),
                    Divider(height: 1, color: AppColors.neutral100),
                    Obx(() {
                      final gender = userController.user.value?.gender ?? 'Female';
                      String iconPath = 'assets/svg/female.svg';
                      if (gender.toLowerCase() == 'male') {
                        iconPath = 'assets/svg/male.svg';
                      } else if (gender.toLowerCase() == 'other') {
                         iconPath = 'assets/svg/othersgender.svg';
                      }
                      return _InfoRow(
                        iconPath: iconPath, 
                        text: gender
                      );
                    }),
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
                          'Delete Account'.tr,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutral900,
                          ),
                        ),
                        content: Text(
                          'Delete Account Confirmation'.tr,
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
                              'Cancel'.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral600,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // Close the dialog first
                              Get.back();
                              
                              // Show loading indicator
                              Get.dialog(
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(
                                          color: AppColors.primaryDark,
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          'Deleting Account'.tr,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.neutral900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );

                              try {
                                // Get ApiService instance
                                final apiService = Get.find<ApiService>();
                                final success = await apiService.deleteAccount();

                                // Close loading dialog
                                Get.back();

                                if (success) {
                                  // Clear user data using controller logout
                                  await userController.logout();
                                  
                                  // Show success message
                                  Get.snackbar(
                                    'Account Deleted'.tr,
                                    'Account Deleted Message'.tr,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: const Color(0xFFFF3232),
                                    colorText: Colors.white,
                                    margin: EdgeInsets.all(16.w),
                                    duration: const Duration(seconds: 3),
                                  );

                                  // Navigate to onboarding screen
                                  Get.offAllNamed(Routes.ONBOARDING);
                                } else {
                                  // Show error message
                                  Get.snackbar(
                                    'Error'.tr,
                                    'Delete Failed'.tr,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    margin: EdgeInsets.all(16.w),
                                  );
                                }
                              } catch (e) {
                                // Close loading dialog if still open
                                if (Get.isDialogOpen ?? false) {
                                  Get.back();
                                }
                                
                                print('❌ Error deleting account: $e');
                                Get.snackbar(
                                  'Error'.tr,
                                  '${'Something Went Wrong'.tr}: $e',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  margin: EdgeInsets.all(16.w),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF3232),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Delete'.tr,
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
                    'Delete'.tr,
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

  Widget _buildFallbackIcon() {
    return Center(
      child: Icon(
        Icons.person,
        size: 32.sp,
        color: const Color(0xFF98A2B3), // Neutral grey
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
        leading: SvgPicture.asset(iconPath, width: 20.w, height: 20.h),
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
          ? SvgPicture.asset(iconPath!, width: 20.w, height: 20.h)
          : Icon(icon, color: AppColors.neutral700, size: 20.sp),
      title: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: AppColors.neutral700),
      ),
    );
  }
}
