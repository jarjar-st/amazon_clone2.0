import 'package:amazon_clone/common/widgets/botton_bar.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/providers/user_provider_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    // final UserController user = Get.find<UserController>();
    // print("HOME: ${user.user.toJson()}");
    return Scaffold(
      // bottomNavigationBar: BottonBar(),
      body: Center(
        child: Text(
          user.toJson(),
        ),
      ),
    );
  }
}
