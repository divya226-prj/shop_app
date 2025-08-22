import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/product_bloc.dart';
import 'package:shop_app/constants/app_image.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/widgets/hometextfield.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> lstProduct = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildappbar,
      body: Column(
        children: [
          _buildcolumnhometxtfield,
          SizedBox(height: 30),

          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductLoaded) {
                lstProduct = state.products;
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
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      lstProduct[index].images?.first ?? "",
                      fit: BoxFit.cover,
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
                              style: TextTheme.of(context).titleLarge?.copyWith(
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
          );
        },
      ),
    ),
  );
}
