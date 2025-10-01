import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Filter/bloc/category_bloc.dart';
import 'package:shop_app/constants/app_color.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/widgets/styled_button.dart';

class FilterScreen extends StatefulWidget {
  final List<int>? initialSelectedCategoryIds;
  final RangeValues? initialPriceRange;

  const FilterScreen({
    super.key,
    this.initialSelectedCategoryIds,
    this.initialPriceRange,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Category> lstCategory = [];
  RangeValues currentPriceRange = const RangeValues(100, 10000);

  @override
  void initState() {
    super.initState();
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (categoryBloc.lstCategory == null) {
      categoryBloc.add(FetchCategories());
    } else {
      lstCategory = categoryBloc.lstCategory!;
    }

    if (widget.initialPriceRange != null) {
      currentPriceRange = widget.initialPriceRange!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.textonsecondary,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close),
        ),
        title: const Text("Filter"),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryLoading) {
            const Center(child: CircularProgressIndicator());
          }
          if (state is CategoryLoaded) {
            setState(() {
              lstCategory = state.category;

              if (widget.initialSelectedCategoryIds != null) {
                for (var category in lstCategory) {
                  if (widget.initialSelectedCategoryIds!.contains(
                    category.id,
                  )) {
                    category.isChecked = false;
                  }
                }
              }
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 1.2,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(51, 158, 158, 158),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        child: Text(
                          "Categories",
                          style: TextStyle(
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
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: category.isChecked
                                        ? AppColor.primary
                                        : Colors.black87,
                                  ),
                                ),
                                value: category.isChecked,
                                onChanged: (_) {
                                  context.read<CategoryBloc>().add(
                                    ToggleCategoryCheckbox(category.id ?? 0),
                                  );
                                },
                                activeColor: AppColor.primary,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              );
                            },
                          ),
                        ),
                      ],
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        child: Text(
                          "Price",
                          style: TextStyle(
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
                            style: const TextStyle(
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
                minimum: const EdgeInsets.all(15),
                child: CustomButton("Apply Filter", () {
                  List<int> selectedCategoryIds = lstCategory
                      .where((category) => category.isChecked)
                      .map((category) => category.id!)
                      .toList();

                  Navigator.pop(context, {
                    "selectedCategoryIds": selectedCategoryIds,
                    "minPrice": currentPriceRange.start.round(),
                    "maxPrice": currentPriceRange.end.round(),
                  });
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
