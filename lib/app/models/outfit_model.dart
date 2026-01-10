class OutfitModel {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final List<Map<String, String>> products;

  OutfitModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.products,
  });
}
