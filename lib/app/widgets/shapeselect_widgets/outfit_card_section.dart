import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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

  final List<String> outfitImages = [
    'assets/image/dress.png',
    'assets/image/dress.png',
    'assets/image/dress.png',
    'assets/image/dress.png',
  ];

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: SizedBox(
        height: 375.h,
        child: CardSwiper(
          controller: _controller,
          cardsCount: outfitImages.length,
          numberOfCardsDisplayed: 3,
          backCardOffset: const Offset(0, 20),
          padding: EdgeInsets.zero,
          onSwipe: _onSwipe,
          onUndo: _onUndo,
          cardBuilder: (context, index, percentX, percentY) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque, // 🔑 full card clickable
              onTap: () => Get.toNamed('/output-outfit'),
              child: Stack(
                children: [
                  OutfitCard(
                    imagePath: outfitImages[index],
                    imageWidth: 210.w,
                    imageHeight: 290.h,
                  ),
                  Positioned(
                    right: 12.w,
                    bottom: 12.h,
                    child: GestureDetector(
                      onTap: () => Get.toNamed('/output-outfit'),
                      child: CircleIconButton(
                        iconPath: 'assets/icons/arrow.png',
                        onTap: () => Get.toNamed('/output-outfit'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // =======================
  // Swipe callbacks
  // =======================

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
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

  void swipeLeft() {
    _controller.swipe(CardSwiperDirection.left);
  }

  void swipeRight() {
    _controller.swipe(CardSwiperDirection.right);
  }
}
