import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/bloc/bloc/wishlist_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/routes/app_routes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Product> lstProduct = [];
  List<Product> cart = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishlistBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourite")),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            final lstProduct = state.products;
            if (lstProduct.isEmpty) {
              return Center(child: Text('Your Wishlist is empty'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: lstProduct.length,
              itemBuilder: (context, index) {
                final product = lstProduct[index];
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
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Rs ${product.price}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColor.textPrimary,
                            ),
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
}
