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

  Future searchProducts() async {}
}
