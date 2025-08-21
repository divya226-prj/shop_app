import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/bloc/product_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
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
            },

            builder: (context, state) {
              return BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return CircularProgressIndicator();
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

  Widget get _buildcolumnhometxtfield =>
      Column(children: [SizedBox(height: 20), Hometextfield()]);

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
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // crossAxisSpacing: 15,
        // mainAxisExtent: 15,
        childAspectRatio: 0.7,
      ),

      itemCount: lstProduct.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  lstProduct[index].image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lstProduct[index].name,
                  style: TextStyle(color: AppColor.textPrimary, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                lstProduct[index].description,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${lstProduct[index].id}",
                style: TextStyle(color: AppColor.textPrimary, fontSize: 12),
              ),
              Text(
                "${lstProduct[index].price}",
                style: TextStyle(color: AppColor.textPrimary, fontSize: 10),
              ),
              Image.asset(AppImage.rating, height: 30, width: 90),
            ],
          ),
        );
      },
    ),
  );
}
