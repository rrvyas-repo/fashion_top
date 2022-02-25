import 'package:flutter/material.dart';

Widget textFormFields(
    {required String? label,
       TextInputType? keyBoardType,
    required TextEditingController txtController,
    required String? hintTexts,
    int maxLine = 1,
    required Color? borderColor,
    required double? borderRadius,
    void Function(String)? onChang}) {
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
          maxLines: maxLine,
          controller: txtController,
          decoration: InputDecoration(
            hintText: hintTexts,
            filled: true,
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
