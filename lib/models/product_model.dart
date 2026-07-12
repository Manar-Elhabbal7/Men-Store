import 'category_model.dart';

class ProductModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final CategoryModel category;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];
    if (json['images'] is List) {
      parsedImages = (json['images'] as List).map((e) => e.toString()).toList();
    } else if (json['images'] is String) {
      final String imagesStr = json['images'].toString();
      if (imagesStr.isNotEmpty) {
        parsedImages = [imagesStr];
      }
    }

    // Clean up urls if they are wrapped in JSON array string representation (Platzi Fake Store API quirk)
    parsedImages = parsedImages
        .map((img) {
          String cleaned = img.trim();
          if (cleaned.startsWith('[') && cleaned.endsWith(']')) {
            cleaned = cleaned.substring(1, cleaned.length - 1);
          }
          if (cleaned.startsWith('"') && cleaned.endsWith('"')) {
            cleaned = cleaned.substring(1, cleaned.length - 1);
          }
          if (cleaned.startsWith('\\"') && cleaned.endsWith('\\"')) {
            cleaned = cleaned.substring(2, cleaned.length - 2);
          }
          return cleaned.replaceAll(r'\"', '').replaceAll('"', '').trim();
        })
        .where((img) => img.isNotEmpty)
        .toList();

    return ProductModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: json['title']?.toString() ?? '',
      price: int.tryParse(json['price']?.toString() ?? '') ?? 0,
      description: json['description']?.toString() ?? '',
      images: parsedImages,
      category: CategoryModel.fromJson(
        json['category'] is Map
            ? Map<String, dynamic>.from(json['category'] as Map)
            : {},
      ),
    );
  }
}
