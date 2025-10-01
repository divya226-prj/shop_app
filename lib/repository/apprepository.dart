import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants/api_constants.dart';
import 'package:shop_app/model/product_model.dart';

class Apprepository {
  Future<List<Product>> fetchproducts(
    int? categoryId,
    double? minPrice,
    double? maxPrice,
  ) async {
    final queryParameters = {
      if (minPrice != null) "price_min": minPrice.toString(),
      if (maxPrice != null) "price_max": maxPrice.toString(),
      if (categoryId != null) "categoryId": categoryId.toString(),
    };

    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiConstants.getProducts}",
    ).replace(queryParameters: queryParameters);

    print("Fetching products from: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      var products = data.map((product) => Product.fromJson(product)).toList();
      print(products.toString());
      return products;
    } else {
      print("Error occurs: ${response.statusCode}");
    }

    return [];
  }

  Future<List<Category>> fetchCategories({
    int? categoryId,
    double? minPrice,
    double? maxPrice,
  }) async {
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getCategories}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      var categories = data.map((item) => Category.fromJson(item)).toList();
      print(categories.toString());
      return categories;
    } else {
      print("Error occurs while fetching categories");
      return [];
    }
  }

  Future searchProducts() async {}
}
