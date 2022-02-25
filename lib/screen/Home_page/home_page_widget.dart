import 'package:fashion_top/utils/colors.dart';
import 'package:flutter/material.dart';

Widget stockDisplayContainer() {
  return Container(
    margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        stops: [9],
        begin: Alignment.bottomCenter,
        end: Alignment.topLeft,
        colors: [Color.fromRGBO(144, 59, 71, 1)],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(right: 40, top: 20, bottom: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Shop',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '36',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 45),
          ),
        ],
      ),
    ),
  );
}

Widget bottomNavigationBarIcon(
  IconData? ic,
  String? txt,
) {
  return GestureDetector(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(ic!),
        Text(txt!),
      ],
    ),
  );
}

Widget listTilesHomePage({
  String? titles,
  String count='',
  IconData? ic,
  void Function()? onTap,
}) {
  return ListTile(
    onTap: onTap,
    title: Text(titles!),
    subtitle: Text(count),
    leading: Icon(
      ic!,
      color: appFromClr,size: 35.0,
    ),
    trailing:const Icon(
      Icons.arrow_forward_ios,
      color: appFromClr,
      size: 25.0,
    ),
  );
}
