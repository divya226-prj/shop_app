import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/product_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/database/wishlist_database.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/widgets/styled_button.dart';

class ProductdetailScreen extends StatefulWidget {
  final Product selectedProduct;

  const ProductdetailScreen({super.key, required this.selectedProduct});

  @override
  State<ProductdetailScreen> createState() => _ProductdetailScreenState();
}

class _ProductdetailScreenState extends State<ProductdetailScreen> {
  final shopAppDatabase = ShopAppDatabase.instance;
  final CarouselSliderController _carousel = CarouselSliderController();
  int currentIndex = 0;
  bool iswishlisted = false;
  bool isExpanded = false;
  List<Product> product = [];

  @override
  Widget build(BuildContext context) {
    final images = (widget.selectedProduct.images ?? []).cast<String>();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (images.isNotEmpty)
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CarouselSlider(
                          carouselController: _carousel,
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
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (Index) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: currentIndex == Index
                                      ? AppColor.primary
                                      : AppColor.tertiary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    right: 20,
                    top: 130,
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.textsubtext,
                        ),
                        onPressed: () {
                          _carousel.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
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
                        SizedBox(
                          width: 300,
                          child: Text(
                            widget.selectedProduct.title ?? "",
                            style: TextTheme.of(context).titleLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),

                        IconButton(
                          color: AppColor.primary,
                          onPressed: () {
                            setState(() {
                              iswishlisted = !iswishlisted;
                            });
                          },
                          icon: iswishlisted
                              ? Icon(CupertinoIcons.heart_fill)
                              : Icon(
                                  CupertinoIcons.heart,
                                  color: AppColor.textPrimary,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          "${widget.selectedProduct.id ?? ""}",
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
                      "${widget.selectedProduct.price ?? ""}",
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
                      widget.selectedProduct.description ?? "",
                      maxLines: isExpanded ? null : 3,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? "Show less" : "More",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(15),
        child: SizedBox(
          height: 65,
          child: CustomButton("Add to Cart", () {
            try {
              BlocProvider.of<ProductBloc>(
                context,
              ).add(AddProductToCart(widget.selectedProduct));

              // ScaffoldMessenger.of(
              //   context,
              // ).showSnackBar(SnackBar(content: Text("Added to cart")));
            } catch (e) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text("Cart feature not initialized")),
              // );
            }
          }),
        ),
      ),
    );
  }
}
