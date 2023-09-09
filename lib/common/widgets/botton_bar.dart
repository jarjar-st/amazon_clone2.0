import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottonBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottonBar({super.key});

  @override
  State<BottonBar> createState() => _BottonBarState();
}

class _BottonBarState extends State<BottonBar> {
  var page = 0.obs;
  double bottonBarWidth = 45;
  double bottonBarBorderWidth = 5;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Obx(
      () => Scaffold(
        body: pages[page.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: page.value,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 28,
          onTap: (value) {
            page.value = value;
          },
          items: [
            // Home
            BottomNavigationBarItem(
              icon: Container(
                width: bottonBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page.value == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottonBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
            // Profile
            BottomNavigationBarItem(
              icon: Container(
                width: bottonBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page.value == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottonBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: '',
            ),
            // Cart
            BottomNavigationBarItem(
              icon: Container(
                width: bottonBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page.value == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottonBarBorderWidth,
                    ),
                  ),
                ),
                child: badges.Badge(
                  badgeContent: Text(userCartLen.toString()),
                  badgeStyle: const badges.BadgeStyle(
                    elevation: 0,
                    badgeColor: Colors.white,
                  ),
                  child:
                      const Center(child: Icon(Icons.shopping_cart_outlined)),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
