import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../service/apiservice.dart';
import '../../../controllers/user_controller.dart';
import '../../favorite/controllers/favorite_controller.dart';


class ShapeselectController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  
  final isLoading = false.obs;
  final generatedImages = <String>[].obs;
  final generatedOutfits = <Map<String, dynamic>>[].obs; // Store complete outfit data
  final selectedStyle = 'Casual'.obs; // Default option
  final temperature = 0.0.obs; // Temperature from UI (in Celsius)
  final isWeatherLoaded = false.obs; // Track if weather is real or default
  final currentLocation = 'Loading...'.obs; // Observable location

  final showOutfitDetails = false.obs;
  final isInitialGenerationDone = false.obs; // Track if first generation is done

  @override
  void onInit() {
    super.onInit();
    getLocation(); // Fetch location on init
    _loadUserReference();
    // Don't auto-generate here, wait for UI to set temperature first
  }

  void _loadUserReference() async {
     try {
       final UserController userController = Get.find<UserController>();
       // Ensure user data is loaded if not already
       if (userController.user.value == null) {
          await userController.fetchUser();
       }
       
       final user = userController.user.value;
       if (user?.fashionPreferences?.style != null) {
          final style = user!.fashionPreferences!.style;
          // Handle both List and String cases from API
          if (style is List && style.isNotEmpty) {
            selectedStyle.value = style.first.toString();
          } else if (style is String) {
            selectedStyle.value = style;
          }
          print('🎨 Loaded user preferred style: ${selectedStyle.value}');
       }
     } catch (e) {
       print('Error loading user reference style: $e');
     }
  }
  
  Future<void> getLocation() async {
    try {
      // 1. Check if services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentLocation.value = 'Location Disabled';
        return;
      }

      // 2. Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          currentLocation.value = 'Permission Denied';
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        currentLocation.value = 'Permission Denied';
        return;
      }

      // 3. FAST RESPONSE: Try last known position first
      // This is near-instant and works great if the user hasn't moved much
      Position? lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        print('📍 Using last known position for fast response');
        _updateLocationAndWeather(lastKnown);
      }

      // 4. ACCURATE RESPONSE: Fetch fresh position in background
      // Using 'high' instead of 'bestForNavigation' for faster lock-on
      // Adding a 5-second timeout so it doesn't hang
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 5),
      ).then((position) {
        print('📍 Fresh position obtained');
        _updateLocationAndWeather(position);
      }).catchError((e) {
        print('📍 Could not get fresh position: $e');
        if (lastKnown == null) {
          currentLocation.value = 'Unknown';
        }
      });

    } catch (e) {
      print('Error in getLocation: $e');
      currentLocation.value = 'Unknown';
    }
  }

  // Helper to process position, update UI and fetch weather
  Future<void> _updateLocationAndWeather(Position position) async {
    try {
      // Get address for UI display
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, 
        position.longitude
      ).timeout(const Duration(seconds: 3));
      
      if (placemarks.isNotEmpty) {
        Placemark p = placemarks.first;
        String city = p.locality ?? p.subAdministrativeArea ?? p.administrativeArea ?? '';
        String country = p.country ?? '';
        
        if (city.isNotEmpty) {
          currentLocation.value = country.isNotEmpty ? '$city, $country' : city;
        } else {
          currentLocation.value = country.isNotEmpty ? country : 'Known Location';
        }
      }

      // Always fetch weather by coordinates (most reliable)
      // This call is async and won't block the UI
      fetchWeatherByCoordinates(position.latitude, position.longitude);
    } catch (e) {
      print('Error updating specific location details: $e');
      // Still try to get weather even if geocoding fails
      fetchWeatherByCoordinates(position.latitude, position.longitude);
    }
  }

  Future<void> fetchWeatherByCoordinates(double lat, double lng) async {
    print('🌦️ Fetching weather for coordinates: $lat, $lng...');
    final weatherData = await _apiService.fetchWeatherByCoordinates(lat, lng);
    _processWeatherData(weatherData);
  }

  Future<void> fetchWeatherAndSetTemperature(String queryLocation) async {
    print('🌦️ Fetching weather for $queryLocation...');
    final weatherData = await _apiService.fetchWeather(queryLocation);
    _processWeatherData(weatherData);
  }

  void _processWeatherData(Map<String, dynamic>? weatherData) {
    if (weatherData != null && weatherData['current'] != null) {
      final current = weatherData['current'];
      final tempC = current['temp_c'];
      
      if (tempC != null) {
        double temp = (tempC as num).toDouble();
        print('🌡️ Weather API returned temp: $temp °C');
        
        isWeatherLoaded.value = true;
        temperature.value = temp;
        
        if (isInitialGenerationDone.value) {
          print('🌦️ Weather received ($temp°C), regenerating outfits...');
          generateOutfit();
        } else {
          updateTemperature(temp);
        }
      }
    } else {
      print('⚠️ Failed to process weather data');
    }
  }

  void updateStyle(String style) {
    selectedStyle.value = style;
    generateOutfit();
  }

  void updateTemperature(double temp) {
    temperature.value = temp;
    
    print('🌡️ ShapeselectController.updateTemperature: $temp');
    
    // If this is the first time temperature is being set, generate outfits
    // If this is the first time temperature is being set, generate outfits
    // Always generate outfits when temperature updates
    // This allows manual edits or weather updates to refresh suggestions
    if (!isInitialGenerationDone.value) {
      isInitialGenerationDone.value = true;
      print('🎨 First time generation triggered');
    }
    
    print('🎨 Temperature updated to $temp, regenerating outfits...');
    generateOutfit();
  }

  Future<void> generateOutfit() async {
    try {
      isLoading.value = true;
      generatedImages.clear();
      generatedOutfits.clear(); // Clear previous outfit data

      final tempValue = temperature.value;
      
      print('===== Generating Outfit =====');
      print('Temperature (from UI): $tempValue°C');
      print('Style: ${selectedStyle.value}');
      print('============================');

      // Generate 5 outfits but don't wait for all to complete
      // Show each image as soon as it's ready
      for (int i = 0; i < 5; i++) {
        _generateSingleOutfit(tempValue, i + 1);
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
        String? title;
        String? description;
        List<dynamic>? products;

        // Extract data from generatedImage object
        if (result['generatedImage'] != null && result['generatedImage'] is Map) {
          final generatedImage = result['generatedImage'] as Map<String, dynamic>;
          url = generatedImage['url'];
          title = generatedImage['title'];
          description = generatedImage['description'];
          products = generatedImage['products'] as List<dynamic>?;
        } else if (result['imageUrl'] != null) {
          url = result['imageUrl']; 
        }

        if (url != null) {
          // Quick fix for localhost/emulator
          if (url.startsWith('http://localhost') && GetPlatform.isAndroid) {
            url = url.replaceFirst('http://localhost', 'http://10.0.2.2');
          }
          
          // Add image to list
          generatedImages.add(url);
          
          // Store complete outfit data
          generatedOutfits.add({
            'url': url,
            'title': title ?? 'AI Generated Outfit',
            'description': description ?? 'Perfect outfit for your style',
            'products': products ?? [],
          });
          
          print('✓ Image $index added: ${generatedImages.length} total');
          print('  Title: $title');
          print('  Products: ${products?.length ?? 0} items');
        }
      }
    } catch (e) {
      print('✗ Generation $index failed: $e');
    }
  }

  void toggleOutfitDetails() => showOutfitDetails.toggle();

  // Add current outfit to favorites
  Future<void> addCurrentOutfitToFavorites(int currentIndex) async {
    try {
      // Validate index
      if (currentIndex < 0 || currentIndex >= generatedOutfits.length) {
        print('❌ Invalid outfit index: $currentIndex');
        Get.snackbar(
          'Error',
          'No outfit selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final outfit = generatedOutfits[currentIndex];
      final imageUrl = outfit['url'] as String;
      final title = outfit['title'] as String? ?? 'AI Generated Outfit';
      final description = outfit['description'] as String? ?? 'Perfect outfit for your style';
      final productsData = outfit['products'] as List<dynamic>? ?? [];

      // Convert products to required format
      final products = productsData.map((p) {
        return {
          'title': p['title']?.toString() ?? '',
          'category': p['category']?.toString() ?? '',
        };
      }).toList();

      print('❤️ Adding outfit to favorites:');
      print('   Title: $title');
      print('   Image: $imageUrl');
      print('   Products: ${products.length}');

      // Call API
      final result = await _apiService.addOutfitToFavorites(
        imageUrl: imageUrl,
        title: title,
        description: description,
        products: products,
      );

      if (result != null) {
        print('✅ Outfit added to favorites successfully');
        
        // Refresh favorite outfits list to show the new addition instantly
        try {
          final favoriteController = Get.find<FavoriteController>();
          await favoriteController.fetchFavoriteOutfits();
          print('🔄 Refreshed favorite outfits list');
        } catch (e) {
          // If FavoriteController is not initialized yet, that's fine
          print('ℹ️ FavoriteController not found, will update on next visit: $e');
        }
        
        Get.snackbar(
          'Success',
          'Outfit added to favorites!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        print('❌ Failed to add outfit to favorites');
        Get.snackbar(
          'Error',
          'Failed to add to favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('❌ Exception adding outfit to favorites: $e');
      Get.snackbar(
        'Error',
        'Failed to add to favorites: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
