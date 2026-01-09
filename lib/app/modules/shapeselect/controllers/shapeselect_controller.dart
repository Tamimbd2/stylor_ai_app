import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../service/apiservice.dart';

class ShapeselectController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  
  final isLoading = false.obs;
  final generatedImages = <String>[].obs;
  final selectedStyle = 'Casual'.obs; // Default option
  final temperature = 0.8.obs; // Default temperature
  final currentLocation = 'Loading...'.obs; // Observable location

  final showOutfitDetails = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLocation(); // Fetch location on init
    generateOutfit(); // Auto-generate on screen load
  }
  
  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      currentLocation.value = 'Location Disabled';
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
        currentLocation.value = 'Permission Denied';
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      currentLocation.value = 'Permission Denied';
      return;
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String city = place.locality ?? '';
        String country = place.country ?? '';
        
        if (city.isNotEmpty && country.isNotEmpty) {
          currentLocation.value = '$city, $country';
        } else if (city.isNotEmpty) {
           currentLocation.value = city;
        } else if (country.isNotEmpty) {
           currentLocation.value = country;
        } else {
           currentLocation.value = 'Unknown Location';
        }
      }
    } catch (e) {
      print('Error getting location: $e');
      currentLocation.value = 'Unknown';
    }
  }

  void updateStyle(String style) {
    selectedStyle.value = style;
    generateOutfit();
  }

  void updateTemperature(double temp) {
    temperature.value = temp;
    generateOutfit();
  }

  Future<void> generateOutfit() async {
    try {
      isLoading.value = true;
      generatedImages.clear(); 

      print('===== Generating Outfit =====');
      print('Temperature: ${temperature.value}');
      print('Style: ${selectedStyle.value}');
      print('============================');

      // Generate 5 outfits but don't wait for all to complete
      // Show each image as soon as it's ready
      for (int i = 0; i < 5; i++) {
        _generateSingleOutfit(temperature.value, i + 1);
      }

      // Wait a bit to show loading state, then mark as not loading
      // But images will continue to populate as they arrive
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;

    } catch (e) {
       print("Error generating outfit: $e");
       Get.snackbar(
        'Error',
        'Failed to generate outfit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }

  // Helper method to generate a single outfit
  Future<void> _generateSingleOutfit(double apiTemperature, int index) async {
    try {
      print('Starting generation $index...');
      
      final result = await _apiService.generateFashion(
        option: selectedStyle.value,
        temperature: apiTemperature,
      );

      if (result != null) {
        String? url;
        if (result['generatedImage'] != null && result['generatedImage'] is Map) {
          url = result['generatedImage']['url'];
        } else if (result['imageUrl'] != null) {
          url = result['imageUrl']; 
        }

        if (url != null) {
          // Quick fix for localhost/emulator
          if (url.startsWith('http://localhost') && GetPlatform.isAndroid) {
            url = url.replaceFirst('http://localhost', 'http://10.0.2.2');
          }
          
          // Add instantly as it arrives
          generatedImages.add(url);
          print('✓ Image $index added instantly: ${generatedImages.length} total');
        }
      }
    } catch (e) {
      print('✗ Generation $index failed: $e');
    }
  }

  void toggleOutfitDetails() => showOutfitDetails.toggle();
}
