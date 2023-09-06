import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Center(
            child: LoadingAnimationWidget.inkDrop(
              color: GlobalVariables.selectedNavBarColor,
              size: 50,
            ),
          )
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: [
                    ResponsiveRowColumnItem(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text(
                          "Ofertas del dia",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Image.network(
                        product!.images[0],
                        height: 235,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "\$100",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding:
                            const EdgeInsets.only(left: 15, top: 5, right: 40),
                        child: const Text(
                          "Benjamin",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 15, bottom: 15),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mirar todas las ofertas",
                          style: TextStyle(
                            color: Colors.cyan[800],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
