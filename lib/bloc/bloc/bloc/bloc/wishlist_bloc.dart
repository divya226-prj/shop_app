import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/database/cart_database.dart';
import 'package:shop_app/database/cart_database.dart' as dbShopApp;

import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/repository/apprepository.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final ShopAppDatabase shopAppDatabase = ShopAppDatabase.instance;
  List<Product> wishlist = [];
  final Apprepository apprepository;
  List<Product>? lstProduct;
  WishlistBloc(this.apprepository) : super(WishlistInitial()) {
    on<FetchProducts>(getProductsFromWishlist);

    on<DeleteProducts>(removeProductsFromWishlist);
  }

  Future<void> getProductsFromWishlist(
    FetchProducts event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    lstProduct = await dbShopApp.readAllForFav();

    emit(WishlistLoaded(products: lstProduct ?? []));
  }

  Future<void> removeProductsFromWishlist(
    DeleteProducts event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      await dbShopApp.deleteForFav(event.id);
      lstProduct?.removeWhere((product) => product.id == event.id);
      emit(WishlistLoaded(products: lstProduct ?? []));
    } catch (e) {
      print(e.toString());
    }
  }
}
