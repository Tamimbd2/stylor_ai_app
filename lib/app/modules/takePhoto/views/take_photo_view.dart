
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../wardrobe/controllers/wardrobe_controller.dart';
import '../controllers/take_photo_controller.dart';
import '../../wardrobe/views/wardrobe_view.dart';

class TakePhotoView extends GetView<TakePhotoController> {
  TakePhotoView({super.key});
  @override
  final TakePhotoController controller = Get.put(TakePhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            /// Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Color(0xFF1C1C1E), size: 24.sp),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                  ),
                  Text(
                    'Take a photo',
                    style: TextStyle(
                      color: Color(0xFF1C1C1E),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
            ),

            /// Camera Preview Container
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(



                    color: Colors.black.withAlpha(48),
                    borderRadius: BorderRadius.circular(24),

                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Obx(() {
                    if (!controller.isInitialized.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    if (controller.capturedImage.value != null) {
                      return Image.file(
                        controller.capturedImage.value!,
                        fit: BoxFit.cover,
                      );
                    }

                    if (controller.cameraController == null) {
                      return Center(
                        child: Text(
                          'Camera not available',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                      );
                    }

                    return CameraPreview(controller.cameraController!);
                  }),
                ),
              ),
            ),

            /// Retake Button
            Obx(() {
              if (controller.capturedImage.value == null) {
                return SizedBox(height: 30.h);
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: GestureDetector(
                  onTap: controller.retakePhoto,
                  child: Container(
                    width: 206.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.48),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Retake photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            /// Bottom Controls or Use Photo Button
            Obx(() {
              if (controller.capturedImage.value != null) {
                /// Show Use Photo Button
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to WardrobeView and start analyzing
                      if (controller.capturedImage.value != null) {
                        Get.back();
                        final wardrobeController = Get.find<WardrobeController>();
                        wardrobeController.startAnalyzing(controller.capturedImage.value!);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF060017),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          'Use this photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              /// Show Camera Controls
              return Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Gallery Button
                    _buildControlButton(
                      icon: Icons.photo_library_outlined,
                      onTap: () {},
                    ),

                    /// Photo Count
                    _buildControlButton(
                      child: Text(
                        '${controller.photoCount.value}',
                        style: TextStyle(
                          color: Color(0xFF060017),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {},
                    ),

                    /// Capture Button
                    GestureDetector(
                      onTap: controller.takePicture,
                      child: Container(
                        width: 56.w,
                        height: 56.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.w,
                            color: const Color(0xFF060017),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x0F101828),
                              blurRadius: 64,
                              offset: const Offset(0, 32),
                              spreadRadius: -12,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 38.w,
                            height: 38.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF060017),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Flash Toggle
                    _buildControlButton(
                      icon: controller.isFlashOn.value
                          ? Icons.flash_on
                          : Icons.flash_off,
                      onTap: controller.toggleFlash,
                    ),

                    /// Switch Camera
                    _buildControlButton(
                      icon: Icons.flip_camera_ios,
                      onTap: controller.switchCamera,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    IconData? icon,
    Widget? child,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 1.w, color: const Color(0xFFF4F4F4)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0F101828),
              blurRadius: 64,
              offset: const Offset(0, 32),
              spreadRadius: -12,
            ),
          ],
        ),
        child: child ?? Icon(icon, color: const Color(0xFF060017), size: 24.sp),
      ),
    );
  }
}
