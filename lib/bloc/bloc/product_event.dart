part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProducts extends ProductEvent {}

class AddProductToCart extends ProductEvent {
  final Product product;
  AddProductToCart(this.product);
}

class SearchQueryChanged extends ProductEvent {
  final String query;
  SearchQueryChanged(this.query);
}
