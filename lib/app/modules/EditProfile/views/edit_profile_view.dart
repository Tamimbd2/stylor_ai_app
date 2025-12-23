import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/color.dart';
import '../../personalize/controllers/personalize_controller.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({super.key});
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final PersonalizeController personalizeController = Get.put(
    PersonalizeController(),
  );
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
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
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
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
                              image: DecorationImage(
                                image: _profileImage != null
                                    ? FileImage(_profileImage!)
                                    : const AssetImage(
                                            'assets/image/profilef.jpg',
                                          )
                                          as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Upload image icon (camera)
                          Positioned(
                            bottom: -6,
                            right: 2.w,
                            child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  setState(() {
                                    _profileImage = File(image.path);
                                  });
                                }
                              },
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
                            Text(
                              'Sara Ali Khan',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutral900,
                              ),
                            ),
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
                Obx(() => _buildSeasonButtons()),

                SizedBox(height: 20.h),

                /// ======================
                /// Style
                /// ======================
                _buildLabel('Style'),
                SizedBox(height: 8.h),
                Obx(() => _buildStyleButtons()),

                SizedBox(height: 20.h),

                /// ======================
                /// Preferences Color
                /// ======================
                _buildLabel('Preferences Color'),
                SizedBox(height: 8.h),
                Obx(() => _buildPreferencesColorButtons()),

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
                      Get.snackbar(
                        'Saved',
                        'Your profile has been updated successfully',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.primaryDark,
                        colorText: Colors.white,
                        margin: EdgeInsets.all(16.w),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Save as',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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
              personalizeController.getFormattedDate(),
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
    final isSelected = personalizeController.selectedGender.value == gender;
    return GestureDetector(
      onTap: () => personalizeController.selectedGender.value = gender,
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
          value: personalizeController.selectedCountry.value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.neutral700),
          items: personalizeController.countries.map((String country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(
                country,
                style: TextStyle(fontSize: 16.sp, color: AppColors.neutral900),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              personalizeController.selectedCountry.value = newValue;
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
            (season) => _buildChipButton(
              season,
              isSelected: personalizeController.selectedSeason.value == season,
              onTap: () => personalizeController.selectedSeason.value = season,
            ),
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
            (style) => _buildChipButton(
              style,
              isSelected: personalizeController.selectedStyle.value == style,
              onTap: () => personalizeController.selectedStyle.value = style,
            ),
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
            (color) => _buildChipButton(
              color,
              isSelected: personalizeController.selectedColor.value == color,
              onTap: () => personalizeController.selectedColor.value = color,
            ),
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
              isSelected: personalizeController.selectedBodyType.value == type,
              onTap: () => personalizeController.selectedBodyType.value = type,
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
              isSelected: personalizeController.selectedSkinTone.value == tone,
              onTap: () => personalizeController.selectedSkinTone.value = tone,
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
          personalizeController.selectedDate.value ?? DateTime(2000, 4, 22),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      personalizeController.selectedDate.value = picked;
    }
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
