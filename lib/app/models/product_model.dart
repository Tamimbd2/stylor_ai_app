class ProductModel {
  final String id;
  final String name;
  final String imagePath; // Local asset path (for backward compatibility)
  final double price;
  final String? category;
  final String? imageUrl; // Network image URL from API
  final String? productUrl; // External product URL for "Buy Now"
  final String? favoriteId; // Server favorite ID for deletion

  ProductModel({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    this.category,
    this.imageUrl,
    this.productUrl,
    this.favoriteId,
  });
}
