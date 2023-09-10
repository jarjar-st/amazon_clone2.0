import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScren extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScren({
    super.key,
    required this.totalAmount,
  });

  @override
  State<AddressScren> createState() => _AddressScrenState();
}

class _AddressScrenState extends State<AddressScren> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String addressToBeUse = '';

  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total a Pagar",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUse,
      );
    }
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUse,
      );
    }
  }

  void payPressed(String addressFromProvider) {
    addressToBeUse = '';

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUse =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}";
      } else {
        throw Exception('Por favor ingresar todos los datos');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUse = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }
    logger.i(addressToBeUse);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      "O",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Gap(20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: flatBuildingController,
                        hintText: "Num casa/Edifico "),
                    const Gap(10),
                    CustomTextField(
                        controller: areaController, hintText: "Area/Calle"),
                    const Gap(10),
                    CustomTextField(
                        controller: pincodeController, hintText: "Pincode"),
                    const Gap(10),
                    CustomTextField(
                        controller: cityController, hintText: "Ciudad"),
                    const Gap(10),
                  ],
                ),
              ),
              const Gap(10),
              if (GetPlatform.isAndroid)
                GooglePayButton(
                  onPressed: () => payPressed(address),
                  width: double.infinity,
                  type: GooglePayButtonType.buy,
                  onPaymentResult: onGooglePayResult,
                  paymentItems: paymentItems,
                  margin: const EdgeInsets.only(top: 50),
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  // paymentConfiguration:
                  // PaymentConfiguration.fromJsonString('gpay.json'),
                  paymentConfigurationAsset: 'gpay.json',
                ),
              if (GetPlatform.isIOS)
                ApplePayButton(
                  onPressed: () => payPressed(address),
                  width: double.infinity,
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  onPaymentResult: onApplePayResult,
                  paymentItems: paymentItems,
                  margin: const EdgeInsets.only(top: 50),
                  paymentConfigurationAsset: "applepay.json",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
