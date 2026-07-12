import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';
import '../../../../models/category_model.dart';
import '../../../../models/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiService _apiService = ApiService();

  final CategoryModel _allCategory = CategoryModel(
    id: -1,
    name: 'All',
    image: '',
  );

  HomeCubit() : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      // Fetch categories
      final categoriesResponse = await _apiService.get('categories');
      final List categoriesData = categoriesResponse.data;
      final allowedCategoryIds = {1, 2, 3, 4};
      final parsedCategories = categoriesData
          .map((e) => CategoryModel.fromJson(e))
          .where((c) => allowedCategoryIds.contains(c.id))
          .toList();

      // Sort categories to match the order: Clothes (1), Electronics (2), Shoes (4), Furniture (3)
      final order = {1: 0, 2: 1, 4: 2, 3: 3};
      parsedCategories.sort(
        (a, b) => (order[a.id] ?? 99).compareTo(order[b.id] ?? 99),
      );

      final categories = [_allCategory, ...parsedCategories];

      // Fetch products
      final productsResponse = await _apiService.get('products');
      final List productsData = productsResponse.data;
      final rawProducts = productsData
          .map((e) => ProductModel.fromJson(e))
          .toList();
      final products = _filterProducts(rawProducts);

      emit(
        HomeLoaded(
          categories: categories,
          products: products,
          selectedCategory: _allCategory,
          isLoadingProducts: false,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> selectCategory(CategoryModel category) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(
        currentState.copyWith(
          selectedCategory: category,
          isLoadingProducts: true,
        ),
      );
      try {
        Map<String, dynamic>? queryParameters;
        if (category.id != -1) {
          queryParameters = {'categoryId': category.id};
        }

        final response = await _apiService.get(
          'products',
          queryParameters: queryParameters,
        );
        final List data = response.data;
        final rawProducts = data.map((e) => ProductModel.fromJson(e)).toList();
        final products = _filterProducts(
          rawProducts,
          selectedCategoryId: category.id,
        );

        emit(
          HomeLoaded(
            categories: currentState.categories,
            products: products,
            selectedCategory: category,
            isLoadingProducts: false,
          ),
        );
      } catch (e) {
        emit(
          HomeLoaded(
            categories: currentState.categories,
            products: currentState.products,
            selectedCategory: category,
            isLoadingProducts: false,
          ),
        );
      }
    }
  }

  List<ProductModel> _filterProducts(
    List<ProductModel> products, {
    int? selectedCategoryId,
  }) {
    return products.where((p) {
      // 1. Filter out products without valid photos (empty or broken placeholders)
      if (p.images.isEmpty || p.images.first.trim().isEmpty) {
        return false;
      }

      final String firstImg = p.images.first.toLowerCase();
      if (firstImg.contains('placeimg.com') ||
          firstImg == 'https://picsum.photos/640/480' ||
          firstImg == 'https://placehold.co/600x400' ||
          firstImg.contains('placehold')) {
        return false;
      }

      // 2. Filter out API sandbox placeholder/test products (e.g., titles containing 'string' or matching 'shoes' exactly)
      final String titleLower = p.title.toLowerCase().trim();
      if (titleLower.contains('string') ||
          titleLower == 'shoes' ||
          titleLower == 'test' ||
          titleLower.contains('testing')) {
        return false;
      }

      // 3. Specific filter for Electronics (ID 2): filter out clothing items
      final int catId = selectedCategoryId ?? p.category.id;
      if (catId == 2 || (selectedCategoryId == -1 && p.category.id == 2)) {
        final String title = p.title.toLowerCase();
        final String desc = p.description.toLowerCase();
        final List<String> clothingKeywords = [
          't-shirt',
          'tshirt',
          'shirt',
          'hoodie',
          'jacket',
          'pant',
          'jeans',
          'short',
          'sock',
          'sweater',
          'sweatshirt',
          'dress',
          'skirt',
          'coat',
          'suit',
          'shoe',
          'sneaker',
          'boot',
          'sandal',
          'clothing',
          'clothes',
          'wear',
        ];
        for (final word in clothingKeywords) {
          if (title.contains(word) || desc.contains(word)) {
            return false;
          }
        }
      }

      return true;
    }).toList();
  }
}
