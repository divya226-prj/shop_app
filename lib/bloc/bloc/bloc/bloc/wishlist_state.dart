part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> products;

  WishlistLoaded({required this.products});
}

class WishlistLoading extends WishlistState {}
