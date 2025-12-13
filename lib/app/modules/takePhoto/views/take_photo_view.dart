import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import '../controllers/take_photo_controller.dart';
import '../../wardrobe/views/wardrobe_view.dart';

class TakePhotoView extends GetView<TakePhotoController> {
  TakePhotoView({super.key});
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF1C1C1E)),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                  ),
                  const Text(
                    'Take a photo',
                    style: TextStyle(
                      color: Color(0xFF1C1C1E),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            /// Camera Preview Container
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.19),
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
                      return const Center(
                        child: Text(
                          'Camera not available',
                          style: TextStyle(color: Colors.white),
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
                return const SizedBox(height: 30);
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: controller.retakePhoto,
                  child: Container(
                    width: 206,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.48),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Retake photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to WardrobeView
                      Get.to(() => const WardrobeView());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF060017),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Use this photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
                padding: const EdgeInsets.only(bottom: 30),
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
                        style: const TextStyle(
                          color: Color(0xFF060017),
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {},
                    ),

                    /// Capture Button
                    GestureDetector(
                      onTap: controller.takePicture,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
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
                            width: 38,
                            height: 38,
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
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: const Color(0xFFF4F4F4)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0F101828),
              blurRadius: 64,
              offset: const Offset(0, 32),
              spreadRadius: -12,
            ),
          ],
        ),
        child: child ?? Icon(icon, color: const Color(0xFF060017), size: 24),
      ),
    );
  }
}
