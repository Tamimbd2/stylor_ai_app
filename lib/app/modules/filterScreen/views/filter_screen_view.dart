import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color.dart';
import '../../../../widgets/primary_button.dart';
import '../../output_outfit/views/main_navigation_view.dart';
import '../controllers/filter_screen_controller.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  FilterScreenView({super.key});
  @override
  final FilterScreenController controller = Get.put(FilterScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                // Logo
                Image.asset('assets/logo/logo.png', height: 60.h),
                SizedBox(height: 40.h),
                // Title
                Text(
                  'Define your fashion DNA.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.neutral900,
                    fontSize: 24.sp,
                    fontFamily: 'Helvetica Neue',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                ),
                SizedBox(height: 10.h),
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
                SizedBox(height: 40.h),
                // Season Section
                _buildSectionTitle('Season'),
                SizedBox(height: 8.h),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 2.5,
                    children: [
                      _FilterChip(
                        label: 'Spring',
                        isSelected: controller.selectedSeason.contains('Spring'),
                        onTap: () => controller.toggleSeason('Spring'),
                      ),
                      _FilterChip(
                        label: 'Summer',
                        isSelected: controller.selectedSeason.contains('Summer'),
                        onTap: () => controller.toggleSeason('Summer'),
                      ),
                      _FilterChip(
                        label: 'Winter',
                        isSelected: controller.selectedSeason.contains('Winter'),
                        onTap: () => controller.toggleSeason('Winter'),
                      ),
                      _FilterChip(
                        label: 'Autumn',
                        isSelected: controller.selectedSeason.contains('Autumn'),
                        onTap: () => controller.toggleSeason('Autumn'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Style Section
                _buildSectionTitle('Style'),
                SizedBox(height: 8.h),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 2.5,
                    children: [
                      _FilterChip(
                        label: 'Casual',
                        isSelected: controller.selectedStyle.contains('Casual'),
                        onTap: () => controller.toggleStyle('Casual'),
                      ),
                      _FilterChip(
                        label: 'Smart Casual',
                        isSelected:
                            controller.selectedStyle.contains('Smart Casual'),
                        onTap: () => controller.toggleStyle('Smart Casual'),
                      ),
                      _FilterChip(
                        label: 'Formal',
                        isSelected: controller.selectedStyle.contains('Formal'),
                        onTap: () => controller.toggleStyle('Formal'),
                      ),
                      _FilterChip(
                        label: 'Streetwear',
                        isSelected:
                            controller.selectedStyle.contains('Streetwear'),
                        onTap: () => controller.toggleStyle('Streetwear'),
                      ),
                      _FilterChip(
                        label: 'Minimalist',
                        isSelected:
                            controller.selectedStyle.contains('Minimalist'),
                        onTap: () => controller.toggleStyle('Minimalist'),
                      ),
                      _FilterChip(
                        label: 'Party',
                        isSelected: controller.selectedStyle.contains('Party'),
                        onTap: () => controller.toggleStyle('Party'),
                      ),
                      _FilterChip(
                        label: 'Artistic',
                        isSelected:
                            controller.selectedStyle.contains('Artistic'),
                        onTap: () => controller.toggleStyle('Artistic'),
                      ),
                      _FilterChip(
                        label: 'Vintage',
                        isSelected: controller.selectedStyle.contains('Vintage'),
                        onTap: () => controller.toggleStyle('Vintage'),
                      ),
                      _FilterChip(
                        label: 'Sporty',
                        isSelected: controller.selectedStyle.contains('Sporty'),
                        onTap: () => controller.toggleStyle('Sporty'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Preferences Color Section
                _buildSectionTitle('Preferences Color'),
                SizedBox(height: 8.h),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 2.5,
                    children: [
                      _FilterChip(
                        label: 'Neutrals',
                        isSelected:
                            controller.selectedColor.contains('Neutrals'),
                        onTap: () => controller.toggleColor('Neutrals'),
                      ),
                      _FilterChip(
                        label: 'Warm Tones',
                        isSelected:
                            controller.selectedColor.contains('Warm Tones'),
                        onTap: () => controller.toggleColor('Warm Tones'),
                      ),
                      _FilterChip(
                        label: 'Cool Tones',
                        isSelected:
                            controller.selectedColor.contains('Cool Tones'),
                        onTap: () => controller.toggleColor('Cool Tones'),
                      ),
                      _FilterChip(
                        label: 'Earthy Tones',
                        isSelected:
                            controller.selectedColor.contains('Earthy Tones'),
                        onTap: () => controller.toggleColor('Earthy Tones'),
                      ),
                      _FilterChip(
                        label: 'Pastels',
                        isSelected: controller.selectedColor.contains('Pastels'),
                        onTap: () => controller.toggleColor('Pastels'),
                      ),
                      _FilterChip(
                        label: 'Vibrant',
                        isSelected: controller.selectedColor.contains('Vibrant'),
                        onTap: () => controller.toggleColor('Vibrant'),
                      ),
                      _FilterChip(
                        label: 'Monochrome',
                        isSelected:
                            controller.selectedColor.contains('Monochrome'),
                        onTap: () => controller.toggleColor('Monochrome'),
                      ),
                      _FilterChip(
                        label: 'Jewel Tones',
                        isSelected:
                            controller.selectedColor.contains('Jewel Tones'),
                        onTap: () => controller.toggleColor('Jewel Tones'),
                      ),
                      _FilterChip(
                        label: 'Metallics',
                        isSelected:
                            controller.selectedColor.contains('Metallics'),
                        onTap: () => controller.toggleColor('Metallics'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Body Type Section
                _buildSectionTitle('Body Type'),
                SizedBox(height: 8.h),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 2.5,
                    children: [
                      _FilterChip(
                        label: 'Curvy',
                        isSelected:
                            controller.selectedBodyType.value == 'Curvy',
                        onTap: () => controller.selectBodyType('Curvy'),
                      ),
                      _FilterChip(
                        label: 'Athletic',
                        isSelected:
                            controller.selectedBodyType.value == 'Athletic',
                        onTap: () => controller.selectBodyType('Athletic'),
                      ),
                      _FilterChip(
                        label: 'Slim',
                        isSelected: controller.selectedBodyType.value == 'Slim',
                        onTap: () => controller.selectBodyType('Slim'),
                      ),
                      _FilterChip(
                        label: 'Pear',
                        isSelected: controller.selectedBodyType.value == 'Pear',
                        onTap: () => controller.selectBodyType('Pear'),
                      ),
                      _FilterChip(
                        label: 'Rectangle',
                        isSelected:
                            controller.selectedBodyType.value == 'Rectangle',
                        onTap: () => controller.selectBodyType('Rectangle'),
                      ),
                      _FilterChip(
                        label: 'Round',
                        isSelected:
                            controller.selectedBodyType.value == 'Round',
                        onTap: () => controller.selectBodyType('Round'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Skin Tone Section
                _buildSectionTitle('Skin Tone'),
                SizedBox(height: 8.h),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 2.5,
                    children: [
                      _FilterChip(
                        label: 'Fair',
                        isSelected: controller.selectedSkinTone.value == 'Fair',
                        onTap: () => controller.selectSkinTone('Fair'),
                      ),
                      _FilterChip(
                        label: 'Light-Medium',
                        isSelected:
                            controller.selectedSkinTone.value == 'Light-Medium',
                        onTap: () => controller.selectSkinTone('Light-Medium'),
                      ),
                      _FilterChip(
                        label: 'Medium',
                        isSelected:
                            controller.selectedSkinTone.value == 'Medium',
                        onTap: () => controller.selectSkinTone('Medium'),
                      ),
                      _FilterChip(
                        label: 'Dark',
                        isSelected: controller.selectedSkinTone.value == 'Dark',
                        onTap: () => controller.selectSkinTone('Dark'),
                      ),
                      _FilterChip(
                        label: 'Medium-Dark',
                        isSelected:
                            controller.selectedSkinTone.value == 'Medium-Dark',
                        onTap: () => controller.selectSkinTone('Medium-Dark'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                // See Outfit Matches Button
                Obx(() => AppButton(
                  text: controller.isLoading.value ? "Processing..." : "See Outfit Matches",
                  textColor: Colors.white,
                  backgroundColor: AppColors.primaryDark,
                  onPressed: controller.isLoading.value 
                    ? () {} 
                    : () => controller.submitPreferences(),
                )),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.neutral900,
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          height: 1.56,
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 112.w,
        height: 34.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : AppColors.neutral100,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.neutral900,
              fontSize: 12.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
