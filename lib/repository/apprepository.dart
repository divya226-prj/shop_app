import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants/api_constants.dart';
import 'package:shop_app/model/product_model.dart';

class Apprepository {
  Future<List<Product>> fetchproducts() async {
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getProducts}"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      var product = data.map((product) => Product.fromJson(product)).toList();
      print(product.toString());
      return product;
    } else {
      print("Error occurs");
    }

    return [];
  }

  Future<List<Category>> fetchCategories() async {
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

  // Future getAllProducts() async {}
  Future<List<Product>> getAllProducts() async {
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getProducts}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      print("Error while fetching all products");
      return [];
    }
  }

  // Future getProductsByCategory(categoryId) async {}
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    final response = await http.get(
      Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.getProducts}?category=$categoryId",
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      print("Error while fetching products by category");
      return [];
    }
  }
}
