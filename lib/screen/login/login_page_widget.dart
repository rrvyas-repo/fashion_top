import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:flutter/material.dart';

String? validateEmail(String? value) {
  String pattern = emailValidateString;
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty || !regex.hasMatch(value)) {
    return emailNotValid;
  } else {
    return null;
  }
}

String? validatePass(String? value) {
  String pattern = passValidateString;
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty || !regex.hasMatch(value)) {
    return passNotValid;
  } else {
    return null;
  }
}

Widget fashionTop() {
  return Container(
    height: 300,
    color: appFromClr,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 55.0,
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          txt(
            textValue: txtFashionTop,
            textFontFamily: "Damion",
            fontSize: 65.0,
            // fontWeight: FontWeight.bold,
          ),
          // Text(
          //   txtFashionTop,
          //   style: const TextStyle(
          //     fontFamily: ,
          //     fontSize: 65,
          //   ),
          // ),
        ],
      ),
    ),
  );
}

Widget txtFrmField({
  ValueChanged<String>? onChanged,
  controllerValue,
  obscureTxt = false,
  keyboardInputType,
  String? Function(String?)? validator, //
  suffixIcn,
  hintTxt,
  labelTxt,
  clr, //
}) {
  return TextFormField(
    onChanged: onChanged,
    // autofillHints: [AutofillHints.email],
    obscureText: obscureTxt,
    controller: controllerValue,
    keyboardType: keyboardInputType,
    autofocus: false,
    validator: validator,
    decoration: InputDecoration(
      fillColor: clr,
      filled: true,
      suffixIcon: suffixIcn,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      hintText: hintTxt,
      label: Text(labelTxt),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  );
}

Widget sizedBox(height) {
  return SizedBox(
    height: height,
  );
}
