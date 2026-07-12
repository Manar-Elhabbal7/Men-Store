class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final int parsedId = int.tryParse(json['id']?.toString() ?? '') ?? 0;
    String parsedName = json['name']?.toString() ?? '';
    if (parsedId == 1 ||
        parsedName == 'Updated Category Name' ||
        parsedName.toLowerCase() == 'updated category') {
      parsedName = 'Clothes';
    }
    return CategoryModel(
      id: parsedId,
      name: parsedName,
      image: json['image']?.toString() ?? '',
    );
  }
}
