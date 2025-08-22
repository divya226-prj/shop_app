part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

final class ProductInitial extends ProductState {}

final class SearchLoading extends ProductState {}

final class SearchLoaded extends ProductState {
  final List<Product> products;
  SearchLoaded(this.products);
}

final class SearchInitial extends ProductState {}
