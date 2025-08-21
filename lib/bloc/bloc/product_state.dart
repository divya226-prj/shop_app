part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

final class ProductInitial extends ProductState {}

class RatingState {
  final double rating;
  RatingState(this.rating);
}
