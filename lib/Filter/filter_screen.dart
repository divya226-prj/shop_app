import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Filter/bloc/category_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/views/home/search_screen.dart';
import 'package:shop_app/widgets/styled_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //  int? categoryId;
  // String? selectedCategoryId;
  // List<int> selectedCategoryIds = [];

  List<Category> lstCategory = [];
  List<bool> categoryChecks = [];

  RangeValues currentPriceRange = RangeValues(100, 10000);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(FetchCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
        title: Text("Filter"),
      ),

      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryLoading) {
            Center(child: CircularProgressIndicator());
          }
          if (state is CategoryLoaded) {
            setState(() {
              lstCategory = state.category;
              categoryChecks = List.generate(lstCategory.length, (_) => false);
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 1.2,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(51, 158, 158, 158),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        child: Text(
                          "Categories",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w100,
                                color: Colors.black87,
                              ),
                        ),
                      ),

                      if (state is CategoryLoaded) ...[
                        Expanded(
                          child: ListView.builder(
                            itemCount: lstCategory.length,
                            itemBuilder: (context, index) {
                              final category = lstCategory[index];
                              return CheckboxListTile(
                                title: Text(
                                  category.name ?? "",
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: categoryChecks[index]
                                            ? AppColor.primary
                                            : Colors.black87,
                                      ),
                                ),
                                value: categoryChecks[index],
                                onChanged: (val) {
                                  setState(() {
                                    categoryChecks[index] = val!;
                                  });
                                },
                                activeColor: AppColor.primary,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              );
                            },
                          ),
                        ),
                      ],

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        child: Text(
                          "Price",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w100,
                                color: Colors.black87,
                              ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "${currentPriceRange.start.round()} - ${currentPriceRange.end.round()}",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                ),
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                              activeTrackColor: AppColor.primary,
                              inactiveTrackColor: AppColor.subtext,
                              overlayColor: AppColor.subtext.withOpacity(0),
                            ),
                            child: RangeSlider(
                              values: currentPriceRange,
                              min: 100,
                              max: 10000,
                              labels: RangeLabels(
                                currentPriceRange.start.round().toString(),
                                currentPriceRange.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  currentPriceRange = values;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                minimum: EdgeInsets.all(15),
                child: CustomButton("Apply Filter", () {
                  int? selectedId;

                  for (int i = 0; i < lstCategory.length; i++) {
                    if (categoryChecks[i]) {
                      selectedId = lstCategory[i].id;
                      break;
                    }
                  }
                  // Navigator.pop(context, selectedId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(selectedId: selectedId),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
