import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import '../../modules/shapeselect/controllers/shapeselect_controller.dart';
import 'common_buttons.dart';
import 'outfit_card.dart';

class OutfitCardSection extends StatefulWidget {
  final VoidCallback onDetailsPressed;

  const OutfitCardSection({Key? key, required this.onDetailsPressed})
    : super(key: key);

  @override
  State<OutfitCardSection> createState() => OutfitCardSectionState();
}

class OutfitCardSectionState extends State<OutfitCardSection> {
  late CardSwiperController _controller;
  int _currentIndex = 0; // Track current card index

  @override
  void initState() {
    super.initState();
    _controller = CardSwiperController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access the parent controller to get generatedImage
    final controller = Get.find<ShapeselectController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: SizedBox(
        height: 375.h,
        child: Obx(() {
          // If we have a generated image, show it on top/as the list
          // For now, let's just use the first card as the dynamic one or replace the list 
          // If your swarm logic depends on a list, we might need to update the list.
          // But simpler approach: Just pass the generated image to the card builder if index==0

          final generatedImages = controller.generatedImages;
          final isLoading = controller.isLoading.value;

          // Show loading card while generating or if empty
          if (isLoading || generatedImages.isEmpty) {
            return _buildLoadingCard();
          }

          // Show minimum of 3 or available images
          final displayCount = generatedImages.length >= 3 ? 3 : generatedImages.length;

          return CardSwiper(
            controller: _controller,
            cardsCount: generatedImages.length,
            numberOfCardsDisplayed: displayCount,
            backCardOffset: const Offset(0, 20),
            padding: EdgeInsets.zero,
            onSwipe: _onSwipe,
            onUndo: _onUndo,
            cardBuilder: (context, index, percentX, percentY) {
              final networkImage = generatedImages[index];
              final outfitData = controller.generatedOutfits.length > index 
                  ? controller.generatedOutfits[index] 
                  : null;

              // Generate queries from products
              String queries = '';
              if (outfitData != null && outfitData['products'] != null) {
                final products = outfitData['products'] as List<dynamic>;
                queries = products
                    .map((p) => p['title'] ?? '')
                    .where((title) => title.isNotEmpty)
                    .join(',');
              }

              // Fallback if no queries
              if (queries.isEmpty) {
                queries = 'Minimalist Watch,White T-Shirt,Chino Shorts';
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque, // 🔑 full card clickable
                onTap: () {
                  print('🎯 Navigating to outfit details:');
                  print('   URL: $networkImage');
                  print('   Title: ${outfitData?['title']}');
                  print('   Queries: $queries');
                  
                  // Navigate with outfit data
                  Get.toNamed(
                    '/output-outfit',
                    arguments: {
                      'imageUrl': networkImage,
                      'description': outfitData?['description'] ?? 'Default Outfit Description'.tr,
                      'queries': queries,
                    },
                  );
                },
                child: Stack(
                  children: [
                    OutfitCard(
                      imagePath: '', // No asset fallback
                      networkImageUrl: networkImage,
                      imageWidth: 335.w,
                      imageHeight: 375.h,
                    ),
                    Positioned(
                      right: 12.w,
                      bottom: 12.h,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            '/output-outfit',
                            arguments: {
                              'imageUrl': networkImage,
                              'description': outfitData?['description'] ?? 'Default Outfit Description'.tr,
                              'queries': queries,
                            },
                          );
                        },
                        child: CircleIconButton(
                          iconPath: 'assets/icons/arrow.png',
                          onTap: () {
                            Get.toNamed(
                              '/output-outfit',
                              arguments: {
                                'imageUrl': networkImage,
                                'description': outfitData?['description'] ?? 'Default Outfit Description'.tr,
                                'queries': queries,
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
    ));
  }

  // =======================
  // Swipe callbacks
  // =======================

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (currentIndex != null) {
      setState(() {
        _currentIndex = currentIndex;
      });
    }
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    return true;
  }

  // =======================
  // External controls
  // =======================

  int get currentIndex => _currentIndex;

  void swipeLeft() {
    _controller.swipe(CardSwiperDirection.left);
  }

  void swipeRight() {
    _controller.swipe(CardSwiperDirection.right);
  }

  // Loading card with Lottie animation
  Widget _buildLoadingCard() {
    return Container(
      width: 335.w,
      height: 375.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Animation
          Lottie.asset(
            'assets/lottie/Dress.json',
            width: 200.w,
            height: 200.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 24.h),
          // Loading Text
          Text(
            'Outfit Generating'.tr,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: 'Helvetica Neue',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Creating Perfect Look'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
