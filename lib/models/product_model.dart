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
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['images']),
      category: CategoryModel.fromJson(json['category']),
    );
  }
}


