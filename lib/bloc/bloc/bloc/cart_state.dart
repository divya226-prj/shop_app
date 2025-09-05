part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Product> cartItems;

  CartLoaded({required this.cartItems});
}

class CartLoading extends CartState {}

class ProductUpdateSuccess extends CartState {
  final List<Product> product;

  ProductUpdateSuccess({required this.product});
}
