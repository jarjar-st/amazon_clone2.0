import 'package:amazon_clone/features/account/widgets/account_buttons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TopButton extends StatefulWidget {
  const TopButton({super.key});

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      columnSpacing: 10,
      layout: ResponsiveRowColumnType.COLUMN,
      children: [
        ResponsiveRowColumnItem(
          child: Row(
            children: [
              AccountButtons(
                text: "Tus Ordenes",
                onPress: () {},
              ),
              AccountButtons(
                text: "Turn Seller",
                onPress: () {},
              ),
            ],
          ),
        ),
        // const ResponsiveRowColumnItem(
        //   child: Gap(10),
        // ),
        ResponsiveRowColumnItem(
          child: Row(
            children: [
              AccountButtons(
                text: "Desconectarse",
                onPress: () {},
              ),
              AccountButtons(
                text: "Tu lista de deseo",
                onPress: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
