import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/color.dart';
import '../../../controllers/user_controller.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is loaded if not already
    // Bindings should handle this, but lazyPut might require find if GetView acts up?
    // GetView calls Get.find internally.
    final userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        // Show skeleton while fetching
        if (controller.isLoading.value) {
          return SafeArea(
            child: Skeletonizer(
              enabled: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      
                      /// Profile Card Skeleton
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: _cardDecoration(),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40.w,
                              backgroundColor: Colors.grey[300],
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Bone.text(
                                    words: 2,
                                    fontSize: 20.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// Birth Date Skeleton
                      Bone.text(words: 2, fontSize: 16.sp),
                      SizedBox(height: 8.h),
                      Container(
                        width: double.infinity,
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.neutral200),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Bone.icon(size: 20.sp),
                            SizedBox(width: 12.w),
                            Bone.text(words: 3),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// Gender Skeleton
                      Bone.text(words: 1, fontSize: 16.sp),
                      SizedBox(height: 8.h),
                      Row(
                        children: List.generate(3, (index) {
                          return Expanded(
                            child: Container(
                              height: 48.h,
                              margin: EdgeInsets.only(right: index < 2 ? 12.w : 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.neutral200),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Bone.icon(size: 20.w),
                                  SizedBox(width: 8.w),
                                  Bone.text(words: 1),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 20.h),

                      /// Country Skeleton
                      Bone.text(words: 1, fontSize: 16.sp),
                      SizedBox(height: 8.h),
                      Container(
                        width: double.infinity,
                        height: 48.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.neutral200),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Bone.text(words: 1, fontSize: 20),
                            SizedBox(width: 8.w),
                            Bone.text(words: 2),
                            Spacer(),
                            Bone.icon(size: 20.sp),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// Season/Style/Color Skeletons
                      ...['Season', 'Style', 'Preferences Color', 'Body Type', 'Skin Tone'].map((label) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Bone.text(words: label.split(' ').length, fontSize: 16.sp),
                            SizedBox(height: 8.h),
                            Wrap(
                              spacing: 12.w,
                              runSpacing: 12.h,
                              children: List.generate(
                                label == 'Body Type' || label == 'Skin Tone' ? 5 : 4,
                                (i) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.neutral100,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Bone.text(words: 1, fontSize: 14.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),

                      SizedBox(height: 12.h),

                      /// Save Button Skeleton
                      Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Bone.text(
                            words: 1,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        
        return SafeArea(
          child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          Obx(() {
                            final localFile = controller.selectedImage.value;
                            final user = userController.user.value;

                            return Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF2F4F7),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.w,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x19101828),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: (() {
                                  if (localFile != null) {
                                    return Image.file(
                                      localFile,
                                      fit: BoxFit.cover,
                                    );
                                  } else if (user?.avatar != null && user!.avatar!.isNotEmpty) {
                                    return Image.network(
                                      user.avatar!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => _buildFallbackIcon(),
                                    );
                                  } else {
                                    return _buildFallbackIcon();
                                  }
                                })(),
                              ),
                            );
                          }),

                          // Upload image icon (camera)
                          Positioned(
                            bottom: -6,
                            right: 2.w,
                            child: GestureDetector(
                              onTap: () => controller.pickImage(),
                              child: Container(
                                width: 28.w,
                                height: 28.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18.w,
                                  color: Colors.black,
                                ),
                              ),
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
                            Obx(() => Text(
                                  userController.user.value?.name ?? 'Sara Ali Khan',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.neutral900,
                                  ),
                                )),
                            SizedBox(height: 8.h),
                            // SizedBox(
                            //   height: 28.h,
                            //   child: ElevatedButton.icon(
                            //     onPressed: () {},
                            //     icon: Image.asset(
                            //       'assets/icons/edit-05.png',
                            //       width: 16.w,
                            //       height: 16.w,
                            //     ),
                            //     label: Text(
                            //       'Edit Profile',
                            //       style: TextStyle(fontSize: 14.sp),
                            //     ),
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: AppColors.primaryDark,
                            //       foregroundColor: Colors.white,
                            //       padding: EdgeInsets.symmetric(horizontal: 16.w),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(6.r),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                /// ======================
                /// Birth Of Date
                /// ======================
                _buildLabel('Birth Of Date'),
                SizedBox(height: 8.h),
                Obx(() => _buildDateField(context)),

                SizedBox(height: 20.h),

                /// ======================
                /// Gender
                /// ======================
                _buildLabel('Gender'),
                SizedBox(height: 8.h),
                Obx(() => _buildGenderButtons()),

                SizedBox(height: 20.h),

                /// ======================
                /// Country
                /// ======================
                _buildLabel('Country'),
                SizedBox(height: 8.h),
                Obx(() => _buildCountryDropdown()),

                SizedBox(height: 20.h),

                /// ======================
                /// Season
                /// ======================
                _buildLabel('Season'),
                SizedBox(height: 8.h),
                _buildSeasonButtons(),

                SizedBox(height: 20.h),

                /// ======================
                /// Style
                /// ======================
                _buildLabel('Style'),
                SizedBox(height: 8.h),
                _buildStyleButtons(),

                SizedBox(height: 20.h),

                /// ======================
                /// Preferences Color
                /// ======================
                _buildLabel('Preferences Color'),
                SizedBox(height: 8.h),
                _buildPreferencesColorButtons(),

                SizedBox(height: 20.h),

                /// ======================
                /// Body Type
                /// ======================
                _buildLabel('Body Type'),
                SizedBox(height: 8.h),
                Obx(() => _buildBodyTypeButtons()),

                SizedBox(height: 20.h),

                /// ======================
                /// Skin Tone
                /// ======================
                _buildLabel('Skin Tone'),
                SizedBox(height: 8.h),
                Obx(() => _buildSkinToneButtons()),

                SizedBox(height: 32.h),

                /// ======================
                /// Save Button
                /// ======================
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.saveProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Obx(() => controller.isUploading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'save_as'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      );
      }),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral900,
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        width: double.infinity,
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.neutral200),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 20.sp,
              color: AppColors.neutral700,
            ),
            SizedBox(width: 12.w),
            Text(
              controller.getFormattedDate(),
              style: TextStyle(fontSize: 16.sp, color: AppColors.neutral900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderButtons() {
    return Row(
      children: [
        Expanded(child: _buildGenderButton('Male', 'assets/image/man.svg')),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildGenderButton('Female', 'assets/image/female.svg'),
        ),
        SizedBox(width: 12.w),
        Expanded(child: _buildGenderButton('Other', 'assets/image/others.svg')),
      ],
    );
  }

  Widget _buildGenderButton(String gender, String iconPath) {
    final isSelected = controller.selectedGender.value == gender;
    return GestureDetector(
      onTap: () => controller.selectedGender.value = gender,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryDark : AppColors.neutral200,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : AppColors.neutral700,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              gender,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? Colors.white : AppColors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryDropdown() {
    // Ensure the selected country is in the list, otherwise use first country
    final currentValue = controller.countries.contains(controller.selectedCountry.value)
        ? controller.selectedCountry.value
        : controller.countries.first;
    
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.neutral700),
          items: controller.countries.map((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Row(
                children: [
                   Text(
                    controller.getCountryFlag(country),
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    country,
                    style: TextStyle(fontSize: 16.sp, color: AppColors.neutral900),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.selectedCountry.value = newValue;
            }
          },
        ),
      ),
    );
  }

  Widget _buildSeasonButtons() {
    final seasons = ['Spring', 'Summer', 'Winter', 'Autumn'];
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: seasons
          .map(
            (season) => Obx(() => _buildChipButton(
              season,
              isSelected: controller.selectedSeason.contains(season),
              onTap: () => controller.toggleSeason(season),
            )),
          )
          .toList(),
    );
  }

  Widget _buildStyleButtons() {
    final styles = [
      'Casual',
      'Smart Casual',
      'Formal',
      'Streetwear',
      'Minimalist',
      'Party',
      'Artistic',
      'Vintage',
      'Sporty',
    ];
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: styles
          .map(
            (style) => Obx(() => _buildChipButton(
              style,
              isSelected: controller.selectedStyle.contains(style),
              onTap: () => controller.toggleStyle(style),
            )),
          )
          .toList(),
    );
  }

  Widget _buildPreferencesColorButtons() {
    final colors = [
      'Neutrals',
      'Warm Tones',
      'Cool Tones',
      'Earthy Tones',
      'Pastels',
      'Vibrant',
      'Monochrome',
      'Jewel Tones',
      'Metallics',
    ];
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: colors
          .map(
            (color) => Obx(() => _buildChipButton(
              color,
              isSelected: controller.selectedColor.contains(color),
              onTap: () => controller.toggleColor(color),
            )),
          )
          .toList(),
    );
  }

  Widget _buildBodyTypeButtons() {
    final bodyTypes = [
      'Curvy',
      'Athletic',
      'Slim',
      'Pear',
      'Rectangle',
      'Round',
    ];
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: bodyTypes
          .map(
            (type) => _buildChipButton(
              type,
              isSelected: controller.selectedBodyType.value == type,
              onTap: () => controller.selectedBodyType.value = type,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSkinToneButtons() {
    final skinTones = ['Fair', 'Light-Medium', 'Medium', 'Dark', 'Medium-Dark'];
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: skinTones
          .map(
            (tone) => _buildChipButton(
              tone,
              isSelected: controller.selectedSkinTone.value == tone,
              onTap: () => controller.selectedSkinTone.value = tone,
            ),
          )
          .toList(),
    );
  }

  Widget _buildChipButton(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : AppColors.neutral100,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : AppColors.neutral900,
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          controller.selectedDate.value ?? DateTime(2000, 4, 22),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.selectedDate.value = picked;
    }
  }

  Widget _buildFallbackIcon() {
    return Center(
      child: Icon(
        Icons.person,
        size: 40.sp,
        color: const Color(0xFF98A2B3), // Neutral grey
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
