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
    on<ToggleCategoryCheckbox>(onToggleCategoryCheckbox);
  }

  Future<void> loadProducts(
    FetchCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    lstCategory = await apprepository.fetchCategories();
    emit(CategoryLoaded(lstCategory ?? []));
  }

  Future<void> onToggleCategoryCheckbox(
    ToggleCategoryCheckbox event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;

      final updatedCategories = currentState.category.map((category) {
        if (category.id == event.categoryId) {
          return category.copyWith(isChecked: !category.isChecked);
        }
        return category;
      }).toList();

      lstCategory = updatedCategories;

      emit(CategoryLoaded(updatedCategories));
    }
  }
}
