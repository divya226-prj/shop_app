import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/bloc/cart_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/routes/app_routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> lstProduct = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final lstProduct = state.cartItems;
            if (lstProduct.isEmpty) {
              return Center(child: Text('Your Cart is empty'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: lstProduct.length,
              itemBuilder: (context, index) {
                final product = lstProduct[index];
                for (var p in lstProduct) {
                  p.quantity = p.quantity == null || p.quantity! < 1
                      ? 1
                      : p.quantity;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.productDetailScreen,
                      arguments: product,
                    );
                  },
                  child: Column(
                    children: [
                      Divider(thickness: 0.5, color: AppColor.textSecondary),
                      SizedBox(height: 30),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            product.images?.first ?? "",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://skala.or.id/wp-content/uploads/2024/01/dummy-post-square-1-1.jpg",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.textontertiary,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if ((product.quantity ?? 1) > 1) {
                                                product.quantity =
                                                    (product.quantity ?? 1) - 1;
                                              }
                                              BlocProvider.of<CartBloc>(
                                                context,
                                              ).add(UpdateProducts(product));
                                            });
                                          },

                                          icon: Icon(
                                            Icons.remove,
                                            color: AppColor.textsubtext,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "${product.quantity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.textontertiary,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              product.quantity =
                                                  (product.quantity ?? 0) + 1;
                                              BlocProvider.of<CartBloc>(
                                                context,
                                              ).add(UpdateProducts(product));
                                            });
                                          },

                                          icon: Icon(
                                            Icons.add,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(
                                    context,
                                  ).add(DeleteProducts(product.id ?? 0));
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: AppColor.textsubtext,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Rs ${_getProductPrice(product)}",

                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

  int _getProductPrice(Product product) {
    return (product.quantity ?? 1) * (product.price ?? 0);
  }
}
