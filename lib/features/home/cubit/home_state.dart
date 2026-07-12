part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final CategoryModel selectedCategory;
  final bool isLoadingProducts;

  HomeLoaded({
    required this.categories,
    required this.products,
    required this.selectedCategory,
    this.isLoadingProducts = false,
  });

  HomeLoaded copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    CategoryModel? selectedCategory,
    bool? isLoadingProducts,
  }) {
    return HomeLoaded(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
    );
  }
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
