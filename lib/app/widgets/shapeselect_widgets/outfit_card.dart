import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/color.dart';

class OutfitCard extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final double imageWidth;
  final double imageHeight;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final BoxShadow? shadow;
  final BoxFit imageFit;

  const OutfitCard({super.key, 
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.shadow,
    this.imageFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 335.w,
      height: height ?? 375.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border.all(width: 1, color: borderColor ?? AppColors.neutral50),
        borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        boxShadow: shadow != null
            ? [shadow!]
            : [
                const BoxShadow(
                  color: Color(0x0F101828),
                  blurRadius: 64,
                  offset: Offset(0, 32),
                  spreadRadius: -12,
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20.r),
        child: Center(
          child: Image.asset(
            imagePath,
            width: imageWidth,
            height: imageHeight,
            fit: imageFit,
          ),
        ),
      ),
    );
  }
}
