part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class FetchCategories extends CategoryEvent {}

class ToggleCategoryCheckbox extends CategoryEvent {
  final int categoryId;
  ToggleCategoryCheckbox(this.categoryId);
}

// class ApplyFilter extends CategoryEvent {
//   final int? categoryId;
//   final double? minPrice;
//   final double? maxPrice;
//   ApplyFilter({this.categoryId, this.maxPrice, this.minPrice});
// }
