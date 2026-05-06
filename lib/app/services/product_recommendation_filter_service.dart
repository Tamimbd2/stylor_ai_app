import '../models/product_model.dart';

class ProductRecommendationFilterService {
  const ProductRecommendationFilterService();

  ProductModel buildProductModel({
    required Map<String, dynamic> rawProduct,
    required List<String> queryTokens,
    String? preferredCategory,
    double? temperature,
    String? preferredStyle,
  }) {
    final name = rawProduct['product_name']?.toString() ?? 'Product';
    final rawCategory = rawProduct['category']?.toString();
    final tags = _extractTags(rawProduct, queryTokens);
    final normalizedCategory = normalizeCategory(
      name: name,
      rawCategory: rawCategory,
      tags: tags,
    );

    final product = ProductModel(
      id: rawProduct['product_url']?.toString() ?? name,
      name: name,
      imagePath: '',
      price: parsePrice(rawProduct['price']),
      category: normalizedCategory,
      imageUrl: rawProduct['image_url']?.toString(),
      productUrl: rawProduct['product_url']?.toString(),
      rawCategory: rawCategory,
      tags: tags,
      isAvailable: rawProduct['available'] != false,
    );

    final score = scoreProduct(
      product: product,
      queryTokens: queryTokens,
      preferredCategory: preferredCategory,
      temperature: temperature,
      preferredStyle: preferredStyle,
    );

    return product.copyWith(recommendationScore: score);
  }

  List<ProductModel> rankProducts({
    required List<Map<String, dynamic>> rawProducts,
    required List<String> queryTokens,
    String? preferredCategory,
    double? temperature,
    String? preferredStyle,
  }) {
    final builtProducts = rawProducts
        .map(
          (rawProduct) => buildProductModel(
            rawProduct: rawProduct,
            queryTokens: queryTokens,
            preferredCategory: preferredCategory,
            temperature: temperature,
            preferredStyle: preferredStyle,
          ),
        )
        .toList();

    builtProducts.sort((a, b) {
      final scoreComparison =
          b.recommendationScore.compareTo(a.recommendationScore);
      if (scoreComparison != 0) {
        return scoreComparison;
      }
      return a.price.compareTo(b.price);
    });

    return builtProducts;
  }

  double parsePrice(dynamic price) {
    if (price == null) {
      return 0.0;
    }
    if (price is num) {
      return price.toDouble();
    }
    if (price is String) {
      final cleaned = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleaned) ?? 0.0;
    }
    return 0.0;
  }

  List<String> parseQueryTokens(String queries) {
    final lower = queries.toLowerCase();
    return lower
        .split(RegExp(r'[,/|]'))
        .map((token) => token.trim())
        .where((token) => token.isNotEmpty)
        .toSet()
        .toList();
  }

  String normalizeCategory({
    required String name,
    String? rawCategory,
    List<String> tags = const [],
  }) {
    final categorySource = [
      name.toLowerCase(),
      rawCategory?.toLowerCase() ?? '',
      ...tags.map((tag) => tag.toLowerCase()),
    ].join(' ');

    if (_containsAny(categorySource, const [
      'shoe',
      'sneaker',
      'boot',
      'sandal',
      'footwear',
      'loafer',
      'heel',
      'slipper',
    ])) {
      return 'Shoes';
    }

    if (_containsAny(categorySource, const [
      'sunglass',
      'glasses',
      'eyewear',
    ])) {
      return 'Sunglass';
    }

    if (_containsAny(categorySource, const [
      'bag',
      'purse',
      'backpack',
      'handbag',
    ])) {
      return 'Bag';
    }

    if (_containsAny(categorySource, const [
      'watch',
      'clock',
      'jewelry',
      'jewellery',
      'accessory',
    ])) {
      return 'Accessory';
    }

    if (_containsAny(categorySource, const [
      'shirt',
      't-shirt',
      'blouse',
      'top',
      'jacket',
      'coat',
      'sweater',
      'hoodie',
      'dress',
      'overshirt',
      'knit',
    ])) {
      return 'upperwear';
    }

    if (_containsAny(categorySource, const [
      'pant',
      'trouser',
      'pants',
      'jeans',
      'short',
      'skirt',
      'denim',
      'legging',
    ])) {
      return 'lowerwear';
    }

    return 'upperwear';
  }

  double scoreProduct({
    required ProductModel product,
    required List<String> queryTokens,
    String? preferredCategory,
    double? temperature,
    String? preferredStyle,
  }) {
    double score = 0;
    final haystack = [
      product.name.toLowerCase(),
      product.category?.toLowerCase() ?? '',
      product.rawCategory?.toLowerCase() ?? '',
      ...product.tags.map((tag) => tag.toLowerCase()),
    ].join(' ');

    for (final token in queryTokens) {
      if (haystack.contains(token)) {
        score += 2;
      }
    }

    if (preferredCategory != null &&
        preferredCategory.isNotEmpty &&
        product.category == preferredCategory) {
      score += 3;
    }

    if (preferredStyle != null &&
        preferredStyle.isNotEmpty &&
        _matchesStyle(product.tags, preferredStyle)) {
      score += 2.5;
    }

    if (temperature != null) {
      score += _temperatureScore(product: product, temperature: temperature);
    }

    if (product.isAvailable) {
      score += 1;
    } else {
      score -= 5;
    }

    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      score += 0.5;
    }

    return score;
  }

  List<String> _extractTags(
    Map<String, dynamic> rawProduct,
    List<String> queryTokens,
  ) {
    final tags = <String>{};
    final rawTags = rawProduct['tags'];

    if (rawTags is List) {
      for (final tag in rawTags) {
        final value = tag.toString().trim();
        if (value.isNotEmpty) {
          tags.add(value);
        }
      }
    } else if (rawTags is String) {
      for (final part in rawTags.split(',')) {
        final value = part.trim();
        if (value.isNotEmpty) {
          tags.add(value);
        }
      }
    }

    final vendor = rawProduct['brand']?.toString();
    if (vendor != null && vendor.isNotEmpty) {
      tags.add(vendor);
    }

    for (final token in queryTokens) {
      tags.add(token);
    }

    return tags.toList();
  }

  bool _containsAny(String source, List<String> keywords) {
    for (final keyword in keywords) {
      if (source.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  bool _matchesStyle(List<String> tags, String preferredStyle) {
    final style = preferredStyle.toLowerCase();
    return tags.any((tag) => tag.toLowerCase().contains(style));
  }

  double _temperatureScore({
    required ProductModel product,
    required double temperature,
  }) {
    final tags = product.tags.map((tag) => tag.toLowerCase()).join(' ');
    final category = product.category?.toLowerCase() ?? '';

    if (temperature <= 12) {
      if (tags.contains('winter') ||
          tags.contains('layer') ||
          category == 'upperwear') {
        return 1.5;
      }
    }

    if (temperature >= 22) {
      if (tags.contains('summer') ||
          tags.contains('linen') ||
          tags.contains('lightweight') ||
          category == 'lowerwear') {
        return 1.5;
      }
    }

    return 0.25;
  }
}
