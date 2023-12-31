import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_row_column.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productPricreController = TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();
  final AdminServices adminServices = AdminServices();

  final category = 'Mobiles'.obs;
  List<File> images = <File>[].obs;
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productDescriptionController.dispose();
    productDescriptionController.dispose();
    productPricreController.dispose();
    productQuantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: productDescriptionController.text,
        price: double.parse(productPricreController.text),
        quantity: double.parse(productQuantityController.text),
        category: category.value,
        images: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });

    print(images.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Center(
              child: Text(
                "Agregar Producto",
                style: TextStyle(),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ResponsiveRowColumn(
                columnPadding: const EdgeInsets.only(top: 20),
                layout: ResponsiveRowColumnType.COLUMN,
                children: [
                  images.isNotEmpty
                      ? ResponsiveRowColumnItem(
                          child: CarouselSlider(
                            items: images.map(
                              (e) {
                                return Builder(
                                  builder: (context) => Image.file(
                                    e,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          ),
                        )
                      : ResponsiveRowColumnItem(
                          child: GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ResponsiveRowColumn(
                                  columnMainAxisAlignment:
                                      MainAxisAlignment.center,
                                  layout: ResponsiveRowColumnType.COLUMN,
                                  columnSpacing: 15,
                                  children: [
                                    const ResponsiveRowColumnItem(
                                      child: Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                    ),
                                    ResponsiveRowColumnItem(
                                      child: Text(
                                        "Seleccione Imagenes del Producto",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  const ResponsiveRowColumnItem(
                    child: Gap(30),
                  ),
                  ResponsiveRowColumnItem(
                    child: CustomTextField(
                      controller: productNameController,
                      hintText: "Nombre del Producto",
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                    child: Gap(10),
                  ),
                  ResponsiveRowColumnItem(
                    child: CustomTextField(
                      controller: productDescriptionController,
                      hintText: "Descripcion del Producto",
                      maxlines: 7,
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                    child: Gap(10),
                  ),
                  ResponsiveRowColumnItem(
                    child: CustomTextField(
                      controller: productPricreController,
                      hintText: "Precio del Producto",
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                    child: Gap(10),
                  ),
                  ResponsiveRowColumnItem(
                    child: CustomTextField(
                      controller: productQuantityController,
                      hintText: "Cantidad del Producto",
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: category.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          category.value = value!;
                        },
                      ),
                    ),
                  ),
                  const ResponsiveRowColumnItem(
                    child: Gap(10),
                  ),
                  ResponsiveRowColumnItem(
                    child: CustomButton(
                      text: "Vender",
                      onPressed: sellProduct,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
