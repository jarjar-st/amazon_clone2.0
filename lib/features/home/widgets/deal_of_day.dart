import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
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
            "https://plus.unsplash.com/premium_photo-1691854350133-8e9a6c8d443c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
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
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
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
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1646021780609-9c908307edc5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1646021780609-9c908307edc5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1646021780609-9c908307edc5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1646021780609-9c908307edc5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://images.unsplash.com/photo-1646021780609-9c908307edc5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        ResponsiveRowColumnItem(
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
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
    );
  }
}
