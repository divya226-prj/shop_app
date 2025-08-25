import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/routes/app_routes.dart';
import 'package:shop_app/widgets/styled_button.dart';

class ProductdetailScreen extends StatelessWidget {
  final Product selectedProduct;
  const ProductdetailScreen({super.key, required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    final images = (selectedProduct.images ?? []).cast<String>();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          if (images.isNotEmpty)
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: CarouselSlider(
                    items: images.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      );
                    }).toList(),

                    options: CarouselOptions(
                      height: 250,
                      viewportFraction: 1,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),

                Positioned(
                  height: 300,
                  width: 800,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedProduct.title ?? "",
                        style: TextTheme.of(context).titleLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w200,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetailScreen,
                          );
                        },
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        "${selectedProduct.id ?? ""}",
                        style: TextTheme.of(context).titleLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Image.asset(AppImage.rating, height: 50, width: 90),
                  SizedBox(height: 10),
                  Text(
                    "${selectedProduct.price ?? ""}",
                    style: TextTheme.of(context).titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Product Details",
                    style: TextTheme.of(context).titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    selectedProduct.description ?? "",
                    style: TextTheme.of(context).titleLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CustomButton("Add to Cart", () {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
