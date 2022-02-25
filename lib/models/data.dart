import 'package:fashion_top/models/product_model.dart';
import 'package:fashion_top/models/school_model.dart';
import 'package:fashion_top/models/size_model.dart';
import 'package:flutter/material.dart';

class ListTileHomePage {
  IconData ic1, ic2;
  String title;
  String subtitle;
  Color clr;

  ListTileHomePage(
      {required this.ic1,
      required this.ic2,
      required this.title,
      required this.subtitle,
      required this.clr});
}

List<ListTileHomePage> pageRoute = [
  ListTileHomePage(
    ic1: Icons.camera,
    ic2: Icons.navigate_next,
    title: 'Schools',
    subtitle: schoolData.length.toString(),
    clr: Colors.yellow,
  ),
  ListTileHomePage(
      ic1: Icons.pest_control_rodent_outlined,
      ic2: Icons.navigate_next,
      title: 'All Products',
      subtitle: productData.length.toString(),
      clr: Colors.indigo),
  ListTileHomePage(
      ic1: Icons.format_size,
      ic2: Icons.navigate_next,
      title: 'Sizes',
      subtitle:sizeData.length.toString() ,
      clr: Colors.pink),
  ListTileHomePage(
      ic1: Icons.stop_circle_rounded,
      ic2: Icons.navigate_next,
      title: 'Stocks',
      subtitle:'05',
      clr: Colors.green),
];
