import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/bloc/bloc/wishlist_bloc.dart' as wishlist;
import 'package:shop_app/bloc/bloc/product_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/routes/app_routes.dart';
import 'package:shop_app/widgets/hometextfield.dart';

class SearchScreen extends StatefulWidget {
  final int? selectedId;

  SearchScreen({super.key, this.selectedId});

  @override
  State<SearchScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<SearchScreen> {
  List<Product> lstProduct = [];
  bool iswishlisted = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(145, 249, 249, 249),
      appBar: _buildappbar,

      body: Column(
        children: [
          _buildcolumnhometxtfield,
          SizedBox(height: 30),

          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              // if (state is ProductLoaded) {
              //   lstProduct = state.products;
              // }
              if (state is ProductLoaded) {
                if (widget.selectedId != null) {
                  lstProduct = state.products
                      .where(
                        (product) => widget.selectedId == product.category?.id,
                      )
                      .toList();
                } else {
                  lstProduct = state.products;
                }
              }

              if (state is SearchLoaded) {
                lstProduct = state.products;
              }
            },

            builder: (context, state) {
              return BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return _buildgridviewbuilder(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _buildcolumnhometxtfield => Column(
    children: [
      SizedBox(height: 20),
      Hometextfield(
        controller: SearchController(),
        onchanged: (value) {
          BlocProvider.of<ProductBloc>(context).add(SearchQueryChanged(value));
        },
      ),
      // SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '${lstProduct.length}+ Items',
              style: TextTheme.of(context).titleLarge?.copyWith(
                color: AppColor.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          // SizedBox(height: 20),
          Spacer(),
          Card(
            child: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColor.textonsecondary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sort",
                    style: TextTheme.of(context).titleLarge?.copyWith(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Icon(Icons.sort),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, AppRoutes.filterScreen);
            },
            child: Card(
              child: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.textonsecondary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Filter",
                      style: TextTheme.of(context).titleLarge?.copyWith(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Icon(Icons.filter_alt_outlined),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Container(
      //   margin: EdgeInsets.only(left: 10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [Text('${lstProduct.length}')],
      //   ),
      // ),
    ],
  );

  Widget get _buildcircleavatar =>
      CircleAvatar(backgroundImage: AssetImage(AppImage.profile), radius: 16);

  Widget get _builappbaricon => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [Image.asset(AppImage.applogo, height: 31)],
  );

  Widget get _buildappbariconbutton => IconButton(
    icon: Icon(Icons.menu, color: Colors.black),
    onPressed: () {},
  );

  PreferredSizeWidget get _buildappbar => AppBar(
    leading: _buildappbariconbutton,
    title: _builappbaricon,
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: _buildcircleavatar,
      ),
    ],
  );

  Widget _buildgridviewbuilder(BuildContext context) => Expanded(
    child: Container(
      margin: EdgeInsets.all(9.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.5,
        ),

        itemCount: lstProduct.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              var product = lstProduct[index];

              Navigator.pushNamed(
                context,
                AppRoutes.productDetailScreen,
                arguments: product,
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.network(
                            lstProduct[index].images?.first ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://skala.or.id/wp-content/uploads/2024/01/dummy-post-square-1-1.jpg",
                              );
                            },
                          ),

                          Positioned(
                            width: 350,
                            height: 20,
                            child: IconButton(
                              color: AppColor.textPrimary,
                              onPressed: () {
                                setState(() {
                                  lstProduct[index].isFavorite =
                                      !(lstProduct[index].isFavorite ?? false);
                                  if (lstProduct[index].isFavorite ?? false) {
                                    BlocProvider.of<ProductBloc>(context).add(
                                      AddProductToWishlist(lstProduct[index]),
                                    );
                                  } else {
                                    BlocProvider.of<wishlist.WishlistBloc>(
                                      context,
                                    ).add(
                                      wishlist.DeleteProducts(
                                        lstProduct[index].id ?? 0,
                                      ),
                                    );
                                  }
                                });
                              },
                              icon: lstProduct[index].isFavorite == true
                                  ? Icon(
                                      CupertinoIcons.heart_fill,
                                      color: AppColor.primary,
                                    )
                                  : Icon(CupertinoIcons.heart),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            lstProduct[index].title ?? "",
                            style: TextTheme.of(context).titleLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),

                          Wrap(
                            children: [
                              Text(
                                lstProduct[index].description ?? "",
                                style: TextTheme.of(context).titleLarge
                                    ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                      letterSpacing: 0.5,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Rs ${lstProduct[index].price}",
                            style: TextTheme.of(context).titleLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                            ),
                          ),

                          Image.asset(AppImage.rating, height: 30, width: 90),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
