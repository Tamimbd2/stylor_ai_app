import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TakePhotoController extends GetxController {
  CameraController? cameraController;
  List<CameraDescription> cameras = [];

  final RxBool isInitialized = false.obs;
  final Rx<File?> capturedImage = Rx<File?>(null);
  final RxBool isFlashOn = false.obs;
  final RxInt photoCount = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      print('Available cameras: ${cameras.length}');

      if (cameras.isEmpty) {
        print('No cameras found');
        return;
      }

      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await cameraController!.initialize();
      await cameraController!.lockCaptureOrientation(
        DeviceOrientation.portraitUp,
      );
      print('Camera initialized successfully');
      print('Camera value: ${cameraController!.value}');
      isInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
      isInitialized.value = false;
    }
  }

  Future<void> takePicture() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    final XFile file = await cameraController!.takePicture();
    capturedImage.value = File(file.path);
  }

  void retakePhoto() {
    capturedImage.value = null;
  }

  void toggleFlash() {
    isFlashOn.toggle();
    cameraController?.setFlashMode(
      isFlashOn.value ? FlashMode.torch : FlashMode.off,
    );
  }

  Future<void> switchCamera() async {
    if (cameras.length < 2 || cameraController == null) return;

    final CameraDescription newCamera =
        cameraController!.description == cameras.first
        ? cameras.last
        : cameras.first;

    isInitialized.value = false;
    await cameraController!.dispose();

    cameraController = CameraController(
      newCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await cameraController!.initialize();
      isInitialized.value = true;
    } catch (e) {
      print('Error switching camera: $e');
      isInitialized.value = false;
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
