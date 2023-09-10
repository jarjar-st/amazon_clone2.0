import 'package:amazon_clone/common/widgets/botton_bar.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case BottonBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottonBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      );
    case ProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const ProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScrean.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScrean(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case AddressScren.routeName:
      var totalAmount = routeSettings.arguments as String;

      return MaterialPageRoute(
        builder: (_) => AddressScren(totalAmount: totalAmount),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("La pagina no existe"),
          ),
        ),
      );
  }
}
