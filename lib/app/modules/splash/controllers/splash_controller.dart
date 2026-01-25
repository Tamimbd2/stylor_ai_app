import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import '../../../controllers/user_controller.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleStartUp();
  }

  Future<void> _handleStartUp() async {
    // 1. First, ensure location permission is granted
    await _checkLocationPermission();
    
    // 2. Then proceed with normal navigation
    await _navigateToNext();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      await Get.dialog(
        AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text('Please enable location services to continue using the app.'),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                Get.back();
                _handleStartUp(); // Retry
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        await Get.dialog(
          AlertDialog(
            title: const Text('Location Permission Required'),
            content: const Text('This app needs location access to provide weather-based outfit suggestions. Please grant permission.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  _checkLocationPermission(); // Retry
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      await Get.dialog(
        AlertDialog(
          title: const Text('Location Permission Denied'),
          content: const Text('Location permissions are permanently denied. Please enable them in settings to use the app.'),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
              child: const Text('Open App Settings'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                _checkLocationPermission(); // Retry
              },
              child: const Text('Check Again'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      return;
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

  Future<void> _navigateToNext() async {
    final userController = Get.find<UserController>();
    
    // Wait for UserController to initialize (load from secure storage)
    while (!userController.isInitialized.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    
    // Wait minimum 3 seconds for splash animation
    await Future.delayed(const Duration(seconds: 3));
    
    // Check if user is logged in
    if (userController.isLoggedIn) {
      print('Auto-login: User is logged in, navigating to Home with Bottom Nav');
      Get.offNamed(Routes.HOME);
    } else {
      print('No token found, navigating to Onboarding');
      Get.offNamed(Routes.ONBOARDING);
    }
  }
}

