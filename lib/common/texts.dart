import 'package:flutter/material.dart';

Widget txt({
  String? textValue,
  color,
  double? fontSize,
  fontWeight,
  String? textFontFamily = "Nunito",
}) {
  return Text(
    textValue!,
    style: TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      fontFamily: textFontFamily,
    ),
  );
}

Widget mtrBtn(
    {double? width, String? txtName, clr, backClr, void Function()? onTap}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    height: 50,
    minWidth: width!,
    onPressed: onTap,
    child: Text(
      txtName!,
      style: TextStyle(color: clr!),
    ),
    color: backClr,
  );
}
