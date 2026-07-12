class CartResponse {
  final List<CartModel> carts;
  final int total;
  final int skip;
  final int limit;

  CartResponse({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      carts:
          (json['carts'] as List?)
              ?.map((e) => CartModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      total: int.tryParse(json['total']?.toString() ?? '') ?? 0,
      skip: int.tryParse(json['skip']?.toString() ?? '') ?? 0,
      limit: int.tryParse(json['limit']?.toString() ?? '') ?? 0,
    );
  }
}

class CartModel {
  final int id;
  final List<CartProduct> products;
  final double total;
  final double discountedTotal;
  final int userId;
  final int totalProducts;
  final int totalQuantity;

  CartModel({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      products:
          (json['products'] as List?)
              ?.map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      total: double.tryParse(json['total']?.toString() ?? '') ?? 0.0,
      discountedTotal:
          double.tryParse(json['discountedTotal']?.toString() ?? '') ?? 0.0,
      userId: int.tryParse(json['userId']?.toString() ?? '') ?? 0,
      totalProducts: int.tryParse(json['totalProducts']?.toString() ?? '') ?? 0,
      totalQuantity: int.tryParse(json['totalQuantity']?.toString() ?? '') ?? 0,
    );
  }
}

class CartProduct {
  final int id;
  final String title;
  final double price;
  int quantity;
  final double total;
  final double discountPercentage;
  final double discountedTotal;
  final String thumbnail;
  final String size;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
    required this.size,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    final id = int.tryParse(json['id']?.toString() ?? '') ?? 0;
    final sizes = ['S', 'M', 'L', 'XL'];
    final size = 'Size ${sizes[id % sizes.length]}';

    return CartProduct(
      id: id,
      title: json['title']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      quantity: int.tryParse(json['quantity']?.toString() ?? '') ?? 0,
      total: double.tryParse(json['total']?.toString() ?? '') ?? 0.0,
      discountPercentage:
          double.tryParse(json['discountPercentage']?.toString() ?? '') ?? 0.0,
      discountedTotal:
          double.tryParse(json['discountedTotal']?.toString() ?? '') ?? 0.0,
      thumbnail: json['thumbnail']?.toString() ?? '',
      size: size,
    );
  }
}
