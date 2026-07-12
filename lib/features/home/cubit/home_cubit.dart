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
      final categories = [
        _allCategory,
        ...categoriesData
            .map((e) => CategoryModel.fromJson(e))
            .where((c) =>
                !c.name.toLowerCase().contains('testing') &&
                !c.name.toLowerCase().contains('test')),
      ];

      // Fetch products
      final productsResponse = await _apiService.get('products');
      final List productsData = productsResponse.data;
      final products = productsData.map((e) => ProductModel.fromJson(e)).toList();

      emit(HomeLoaded(
        categories: categories,
        products: products,
        selectedCategory: _allCategory,
        isLoadingProducts: false,
      ));
    } catch (e) {
      emit(HomeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> selectCategory(CategoryModel category) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(
        selectedCategory: category,
        isLoadingProducts: true,
      ));
      try {
        Map<String, dynamic>? queryParameters;
        if (category.id != -1) {
          queryParameters = {'categoryId': category.id};
        }
        
        final response = await _apiService.get('products', queryParameters: queryParameters);
        final List data = response.data;
        final products = data.map((e) => ProductModel.fromJson(e)).toList();

        emit(HomeLoaded(
          categories: currentState.categories,
          products: products,
          selectedCategory: category,
          isLoadingProducts: false,
        ));
      } catch (e) {
        emit(HomeError(e.toString().replaceAll('Exception: ', '')));
      }
    }
  }
}
