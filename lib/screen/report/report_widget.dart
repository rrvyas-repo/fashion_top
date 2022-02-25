import 'package:fashion_top/utils/colors.dart';
import 'package:flutter/material.dart';

txtFrmFieldDate(
    {onTapValue,
      bool boolValue = false,
      controllerValue,
      txtInputType,
      required IconData suffixIcn,
      hintTxt,
      labelTxt,
      String Function(String?)? functionName}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: TextFormField(
      readOnly: boolValue,
      onTap: onTapValue,
      controller: controllerValue,
      keyboardType: txtInputType,
      decoration: InputDecoration(
        enabledBorder: txtFieldBorder(clr: enableBorderTxtFieldClr),
        focusedBorder: txtFieldBorder(clr: focusedBorderTxtFieldClr),
        errorBorder: txtFieldBorder(clr: errorBorderTxtFieldClr),
        focusedErrorBorder: txtFieldBorder(clr: focusedErrorBorderTxtFieldClr),
        fillColor: fillColorTxtField,
        filled: true,
        suffixIcon: Icon(suffixIcn),
        hintText: hintTxt,
        labelText: labelTxt,
        labelStyle: TextStyle(
          color: labelStyleTxtFieldClr,
        ),
      ),
      validator: functionName,
    ),
  );
}

txtFieldBorder({clr}) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(color: clr),
  );
}


checkInOutDate(
    {contextValue,
      initialDateValue,
      firstDate,
      dateInputCheckInOut,
      required void setState(void Function() param0)}) =>
        () async {
      await showDatePicker(
          context: contextValue,
          initialDate: initialDateValue,
          //firstDate: DateTime(2000),
          firstDate: firstDate,
          lastDate: DateTime(2025))
          .then((value) {
        setState(() {
          initialDateValue = value as DateTime;
          dateInputCheckInOut.text = initialDateValue.day.toString() +
              '/' +
              initialDateValue.month.toString() +
              '/' +
              initialDateValue.year.toString();
        });
      });
    };
// sizeBox({width}) {
//   return SizedBox(
//     height: sizeBoxHeight,
//     width: width,
//   );
// }
