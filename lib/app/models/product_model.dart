class ProductModel {
  final String id;
  final String name;
  final String imagePath; // Local asset path (for backward compatibility)
  final double price;
  final String? category;
  final String? imageUrl; // Network image URL from API
  final String? productUrl; // External product URL for "Buy Now"
  final String? favoriteId; // Server favorite ID for deletion
  final String? rawCategory; // Original category from backend if available
  final List<String> tags; // Extra metadata for filtering and ranking
  final bool isAvailable; // Supports stronger filtering for recommendations
  final double recommendationScore; // Used to rank recommendation results

  ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    this.category,
    this.imageUrl,
    this.productUrl,
    this.favoriteId,
    this.rawCategory,
    this.tags = const [],
    this.isAvailable = true,
    this.recommendationScore = 0,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? imagePath,
    double? price,
    String? category,
    String? imageUrl,
    String? productUrl,
    String? favoriteId,
    String? rawCategory,
    List<String>? tags,
    bool? isAvailable,
    double? recommendationScore,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      productUrl: productUrl ?? this.productUrl,
      favoriteId: favoriteId ?? this.favoriteId,
      rawCategory: rawCategory ?? this.rawCategory,
      tags: tags ?? this.tags,
      isAvailable: isAvailable ?? this.isAvailable,
      recommendationScore: recommendationScore ?? this.recommendationScore,
    );
  }
}
