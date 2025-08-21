import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/repository/apprepository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Apprepository apprepository;
  ProductBloc(this.apprepository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      final products = await apprepository.fetchproducts();
      emit(ProductLoaded(products));
    });
  }
}
