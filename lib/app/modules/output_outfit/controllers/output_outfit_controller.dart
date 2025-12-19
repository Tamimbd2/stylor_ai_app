import 'package:get/get.dart';
import '../../../models/product_model.dart';

class OutputOutfitController extends GetxController {
  //TODO: Implement OutputOutfitController

  final count = 0.obs;
  final selectedChip = 'All'.obs;
  final isFeaturedOutfitFavorited = false.obs;
  final favoriteProducts = <int>{}.obs;
  
  // All products list
  final allProducts = <ProductModel>[
    ProductModel(
      id: '1',
      name: 'ONLMADISON High waist Wide Leg Fit Jeans',
      imagePath: 'assets/image/clothes.png',
      price: 20.50,
      category: 'bottoms',
    ),
    ProductModel(
      id: '2',
      name: 'Elegant Summer Dress',
      imagePath: 'assets/image/dreess1.png',
      price: 35.99,
      category: 'Top',
    ),
    ProductModel(
      id: '3',
      name: 'Classic Black Shoes',
      imagePath: 'assets/image/shoe.png',
      price: 45.00,
      category: 'Top',
    ),
    ProductModel(
      id: '4',
      name: 'Designer Party Dress',
      imagePath: 'assets/image/dress2.png',
      price: 55.50,
      category: 'Top',
    ),
    ProductModel(
      id: '5',
      name: 'Stylish Sunglasses',
      imagePath: 'assets/image/sunglass.png',
      price: 25.00,
      category: 'Sunglass',
    ),
  ].obs;
  
  // Filtered products based on selected category
  List<ProductModel> get filteredProducts {
    if (selectedChip.value == 'All') {
      return allProducts;
    }
    return allProducts.where((product) => product.category == selectedChip.value).toList();
  }
  
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
