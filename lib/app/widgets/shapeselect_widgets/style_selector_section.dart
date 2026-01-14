import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../modules/shapeselect/controllers/shapeselect_controller.dart';
import '../../../core/color.dart';

class StyleSelectorSection extends StatelessWidget {
  final String selectedStyle;
  final ValueChanged<String> onStyleChanged;

  const StyleSelectorSection({super.key, 
    required this.selectedStyle,
    required this.onStyleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: GestureDetector(
        onTap: () => _showStyleSelector(context),
        child: Container(
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
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  selectedStyle.tr,
                  style: TextStyle(
                    color: AppColors.neutral700,
                    fontSize: 13.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 14.sp,
                color: AppColors.neutral700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStyleSelector(BuildContext context) {
    final styles = [
      'Casual',
      'Smart Casual',
      'Formal',
      'Streetwear',
      'Minimalist',
      'Party',
      'Artistic',
      'Vintage',
      'Sporty'
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return StyleSelectBottomSheet(
          styles: styles,
          selectedStyle: selectedStyle,
          onStyleSelected: (style) {
            onStyleChanged(style);
            Get.find<ShapeselectController>().updateStyle(style);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class StyleSelectBottomSheet extends StatelessWidget {
  final List<String> styles;
  final String selectedStyle;
  final ValueChanged<String> onStyleSelected;

  const StyleSelectBottomSheet({super.key, 
    required this.styles,
    required this.selectedStyle,
    required this.onStyleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Style'.tr,
              style: TextStyle(
                color: AppColors.neutral900,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: styles.length,
              itemBuilder: (context, index) {
                final style = styles[index];
                final isSelected = selectedStyle == style;
                return StyleOption(
                  style: style,
                  isSelected: isSelected,
                  onTap: () => onStyleSelected(style),
                );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class StyleOption extends StatelessWidget {
  final String style;
  final bool isSelected;
  final VoidCallback onTap;

  const StyleOption({super.key, 
    required this.style,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryDark : Colors.transparent,
                border: Border.all(
                  width: 2,
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.neutral300,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                style.tr,
                style: TextStyle(
                  color: AppColors.neutral700,
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
