import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/database/wishlist_database.dart';
import 'package:shop_app/model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final shopAppDatabase = ShopAppDatabase.instance;
  List<Product> product = [];

  @override
  dispose() {
    // shopAppDatabase.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
