import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_row_column.dart';

class ProductScreen extends StatefulWidget {
  static const String routeName = '/products';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<ProductScreen> {
  List<Product>? productList;
  final AdminServices adminServices = AdminServices();
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    fetAllProduct();
  }

  fetAllProduct() async {
    productList = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        productList!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? Center(
            child: LoadingAnimationWidget.inkDrop(
              color: GlobalVariables.selectedNavBarColor,
              size: 50,
            ),
          )
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                final productData = productList![index];
                return ResponsiveRowColumn(
                  layout: ResponsiveRowColumnType.COLUMN,
                  children: [
                    ResponsiveRowColumnItem(
                      child: SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                    ),
                    ResponsiveRowColumnItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: navigateToAddProduct,
              tooltip: "Agregar un producto",
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: GlobalVariables.appBarGradient,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
