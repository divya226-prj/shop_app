part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class FetchProducts extends CartEvent {}

class UpdateProducts extends CartEvent {
  final Product product;
  UpdateProducts(this.product);
}

class DeleteProducts extends CartEvent {
  final int id;
  DeleteProducts(this.id);
}
