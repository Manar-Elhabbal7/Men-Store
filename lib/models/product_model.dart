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
    return ProductModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: json['title']?.toString() ?? '',
      price: int.tryParse(json['price']?.toString() ?? '') ?? 0,
      description: json['description']?.toString() ?? '',
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
