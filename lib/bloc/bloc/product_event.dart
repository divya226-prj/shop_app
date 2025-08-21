part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProducts extends ProductEvent {}

class AddProductToCart extends ProductEvent {
  final Product product;
  AddProductToCart(this.product);
}

class RatingUpdatedEvent extends ProductEvent {
  final double rating;
  RatingUpdatedEvent(this.rating);
}
