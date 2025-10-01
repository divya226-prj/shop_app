import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/database/cart_database.dart';
import 'package:shop_app/database/cart_database.dart' as dbShopApp;
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/repository/apprepository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final shopAppDatabase = ShopAppDatabase.instance;
  List<Product> cart = [];
  final Apprepository apprepository;

  List<Product>? lstProduct;
  ProductBloc(this.apprepository) : super(ProductInitial()) {
    on<FetchProducts>(loadProducts);
    on<SearchQueryChanged>(searchProducts);
    on<AddProductToCart>(cartProducts);
    on<AddProductToWishlist>(addproductsToWishlist);
  }

  Future<void> loadProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    lstProduct = await apprepository.fetchproducts(
      event.categoryId,
      event.minPrice,
      event.maxPrice,
    );

    var wishlistProducts = await dbShopApp.readAllForFav();

    for (var wishproduct in wishlistProducts) {
      int index = (lstProduct ?? []).indexWhere(
        (product) => wishproduct.id == product.id,
      );
      if (index != -1) {
        lstProduct?[index].isFavorite = true;
      }
      // lstProduct!.firstWhere((product) => wishproduct.id == product.id);
    }

    emit(ProductLoaded(lstProduct ?? []));
  }

  Future<void> searchProducts(
    SearchQueryChanged event,
    Emitter<ProductState> emit,
  ) async {
    emit(SearchLoading());
    var searchQuery = event.query.toLowerCase();
    var filteredProducts = lstProduct
        ?.where(
          (product) =>
              product.title.toString().toLowerCase().contains(searchQuery) ||
              product.description.toString().toLowerCase().contains(
                searchQuery,
              ),
        )
        .toList();
    emit(SearchLoaded(filteredProducts ?? []));
  }

  Future<void> cartProducts(
    AddProductToCart event,
    Emitter<ProductState> emit,
  ) async {
    emit(CartLoading());

    try {
      await dbShopApp.add(event.product);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addproductsToWishlist(
    AddProductToWishlist event,
    Emitter<ProductState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      await dbShopApp.addForFav(event.product);
    } catch (e) {
      print(e.toString());
    }
  }
}
