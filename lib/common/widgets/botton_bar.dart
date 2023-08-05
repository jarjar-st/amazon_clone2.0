import 'package:amazon_clone/constants/global_varaiables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

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
    const Center(
      child: Text("Account Page"),
    ),
    const Center(
      child: Text("Cart Page"),
    ),
  ];
  Widget build(BuildContext context) {
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
                child: const badges.Badge(
                  badgeContent: Text('2'),
                  badgeStyle: badges.BadgeStyle(
                    elevation: 0,
                    badgeColor: Colors.white,
                  ),
                  child: Center(child: Icon(Icons.shopping_cart_outlined)),
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
