import 'package:get/get.dart';

class OutputOutfitController extends GetxController {
  //TODO: Implement OutputOutfitController

  final count = 0.obs;
  final selectedChip = 'All'.obs;
  final isFeaturedOutfitFavorited = false.obs;
  final favoriteProducts = <int>{}.obs;
  
  // Card swipe functionality
  final currentCardIndex = 0.obs;
  final cardFavorites = <int>{}.obs;
  
  // Sample outfit cards data
  final outfitCards = [
    {
      'image': 'assets/image/dress.png',
      'description': 'This is really white shirt and black pant black show which show for this wither. it will match very good for this session'
    },
    {
      'image': 'assets/image/clothes.png',
      'description': 'Casual outfit perfect for a day out with friends. Comfortable and stylish.'
    },
    {
      'image': 'assets/image/dreess1.png',
      'description': 'Elegant evening wear that combines sophistication with modern style.'
    },
    {
      'image': 'assets/image/dress2.png',
      'description': 'Summer vibes with this light and breezy outfit. Perfect for warm weather.'
    },
    {
      'image': 'assets/image/shoe.png',
      'description': 'Professional attire suitable for office meetings and formal events.'
    },
  ];

  void toggleFeaturedFavorite() {
    isFeaturedOutfitFavorited.value = !isFeaturedOutfitFavorited.value;
  }

  void toggleProductFavorite(int index) {
    if (favoriteProducts.contains(index)) {
      favoriteProducts.remove(index);
    } else {
      favoriteProducts.add(index);
    }
  }
  
  void toggleCardFavorite() {
    if (cardFavorites.contains(currentCardIndex.value)) {
      cardFavorites.remove(currentCardIndex.value);
    } else {
      cardFavorites.add(currentCardIndex.value);
    }
  }
  
  void nextCard() {
    if (currentCardIndex.value < outfitCards.length - 1) {
      currentCardIndex.value++;
    } else {
      // Loop back to first card
      currentCardIndex.value = 0;
    }
  }
  
  void likeAndNextCard() {
    if (!cardFavorites.contains(currentCardIndex.value)) {
      cardFavorites.add(currentCardIndex.value);
    }
    nextCard();
  }
  
  void dislikeAndNextCard() {
    cardFavorites.remove(currentCardIndex.value);
    nextCard();
  }

  void selectChip(String chipLabel) {
    selectedChip.value = chipLabel;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
