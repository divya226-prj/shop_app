part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class FetchProducts extends WishlistEvent {}

class DeleteProducts extends WishlistEvent {
  final int id;
  DeleteProducts(this.id);
}
