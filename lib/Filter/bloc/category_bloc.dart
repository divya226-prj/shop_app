import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/database/cart_database.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/repository/apprepository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final shopAppDatabase = ShopAppDatabase.instance;
  final Apprepository apprepository;
  List<Category>? lstCategory;
  CategoryBloc(this.apprepository) : super(CategoryInitial()) {
    on<FetchCategories>(loadProducts);
  }

  Future<void> loadProducts(
    FetchCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    lstCategory = await apprepository.fetchCategories();
    emit(CategoryLoaded(lstCategory ?? []));
  }
}
