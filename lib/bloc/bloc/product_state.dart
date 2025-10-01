part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> products;
  final int totalCount;
  ProductLoaded(this.products) : totalCount = products.length;
}

final class ProductInitial extends ProductState {}

final class SearchLoading extends ProductState {}

final class SearchLoaded extends ProductState {
  final List<Product> products;
  final int totalCount;
  SearchLoaded(this.products) : totalCount = products.length;
}

final class SearchInitial extends ProductState {}

final class CartLoaded extends ProductState {
  final List<Product> products;
  CartLoaded(this.products);
}

class CartError extends ProductState {
  final String message;
  CartError(this.message);
}

class WishlistLoaded extends ProductState {
  final List<Product> products;

  WishlistLoaded({required this.products});
}

class WishlistLoading extends ProductState {}

final class CartLoading extends ProductState {}
