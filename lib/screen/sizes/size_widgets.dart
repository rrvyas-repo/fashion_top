import 'package:flutter/material.dart';

Widget textFormFields({
  required String? label,
  required TextEditingController txtController,
  int maxLine = 1,
  required Color? borderColor,
  required double? borderRadius,
  void Function(String)? onChang,
  // required String? Function(String? p0) validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 28.0, top: 10.0),
        child: Text(label!),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 7.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          maxLines: maxLine,
          controller: txtController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Enter Size',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor!),
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onChanged: onChang,
        ),
      ),
    ],
  );
}
