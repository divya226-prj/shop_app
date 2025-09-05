import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/database/cart_database.dart';
import 'package:shop_app/database/cart_database.dart' as dbShopApp;

import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/repository/apprepository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShopAppDatabase shopAppDatabase = ShopAppDatabase.instance;
  final Apprepository apprepository;
  List<Product>? lstProduct;
  CartBloc(this.apprepository) : super(CartInitial()) {
    on<FetchProducts>(getProductsFromCart);
    on<DeleteProducts>(removeProductsFromCart);
    on<UpdateProducts>(updateProductForCart);
  }

  Future<void> getProductsFromCart(
    FetchProducts event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      lstProduct = await dbShopApp.readAll();
      emit(CartLoaded(cartItems: lstProduct ?? []));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProductForCart(
    UpdateProducts event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await dbShopApp.updateProducts(event.product);
      emit(CartLoaded(cartItems: lstProduct ?? []));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeProductsFromCart(
    DeleteProducts event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await dbShopApp.delete(event.id);
      lstProduct?.removeWhere((product) => product.id == event.id);
      emit(CartLoaded(cartItems: lstProduct ?? []));
    } catch (e) {
      print(e.toString());
    }
  }
}
