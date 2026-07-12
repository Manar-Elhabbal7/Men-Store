import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';
import '../../../../models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService _apiService = ApiService();

  CartCubit() : super(CartInitial());

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final response = await _apiService.get(
        'https://dummyjson.com/carts/user/1',
      );
      final cartResponse = CartResponse.fromJson(response.data);
      if (cartResponse.carts.isNotEmpty) {
        emit(CartLoaded(cartResponse.carts.first));
      } else {
        emit(
          CartLoaded(
            CartModel(
              id: 0,
              products: [],
              total: 0.0,
              discountedTotal: 0.0,
              userId: 1,
              totalProducts: 0,
              totalQuantity: 0,
            ),
          ),
        );
      }
    } catch (e) {
      emit(CartError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void incrementQuantity(int productId) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final cart = currentState.cart;
      final products = List<CartProduct>.from(cart.products);
      final index = products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        final product = products[index];
        final newQty = product.quantity + 1;
        products[index] = CartProduct(
          id: product.id,
          title: product.title,
          price: product.price,
          quantity: newQty,
          total: product.price * newQty,
          discountPercentage: product.discountPercentage,
          discountedTotal:
              (product.price * newQty) * (1 - product.discountPercentage / 100),
          thumbnail: product.thumbnail,
          size: product.size,
        );

        final newTotal = products.fold<double>(0.0, (sum, p) => sum + p.total);
        final newDiscountedTotal = products.fold<double>(
          0.0,
          (sum, p) => sum + p.discountedTotal,
        );
        final newTotalQuantity = products.fold<int>(
          0,
          (sum, p) => sum + p.quantity,
        );

        emit(
          CartLoaded(
            CartModel(
              id: cart.id,
              products: products,
              total: newTotal,
              discountedTotal: newDiscountedTotal,
              userId: cart.userId,
              totalProducts: products.length,
              totalQuantity: newTotalQuantity,
            ),
          ),
        );
      }
    }
  }

  void decrementQuantity(int productId) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final cart = currentState.cart;
      final products = List<CartProduct>.from(cart.products);
      final index = products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        final product = products[index];
        if (product.quantity > 1) {
          final newQty = product.quantity - 1;
          products[index] = CartProduct(
            id: product.id,
            title: product.title,
            price: product.price,
            quantity: newQty,
            total: product.price * newQty,
            discountPercentage: product.discountPercentage,
            discountedTotal:
                (product.price * newQty) *
                (1 - product.discountPercentage / 100),
            thumbnail: product.thumbnail,
            size: product.size,
          );

          final newTotal = products.fold<double>(
            0.0,
            (sum, p) => sum + p.total,
          );
          final newDiscountedTotal = products.fold<double>(
            0.0,
            (sum, p) => sum + p.discountedTotal,
          );
          final newTotalQuantity = products.fold<int>(
            0,
            (sum, p) => sum + p.quantity,
          );

          emit(
            CartLoaded(
              CartModel(
                id: cart.id,
                products: products,
                total: newTotal,
                discountedTotal: newDiscountedTotal,
                userId: cart.userId,
                totalProducts: products.length,
                totalQuantity: newTotalQuantity,
              ),
            ),
          );
        }
      }
    }
  }

  void removeProduct(int productId) {
    final currentState = state;
    if (currentState is CartLoaded) {
      final cart = currentState.cart;
      final products = List<CartProduct>.from(cart.products)
        ..removeWhere((p) => p.id == productId);

      final newTotal = products.fold<double>(0.0, (sum, p) => sum + p.total);
      final newDiscountedTotal = products.fold<double>(
        0.0,
        (sum, p) => sum + p.discountedTotal,
      );
      final newTotalQuantity = products.fold<int>(
        0,
        (sum, p) => sum + p.quantity,
      );

      emit(
        CartLoaded(
          CartModel(
            id: cart.id,
            products: products,
            total: newTotal,
            discountedTotal: newDiscountedTotal,
            userId: cart.userId,
            totalProducts: products.length,
            totalQuantity: newTotalQuantity,
          ),
        ),
      );
    }
  }
}
