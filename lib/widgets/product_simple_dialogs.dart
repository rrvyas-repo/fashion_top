import 'package:fashion_top/models/product_model.dart';
import 'package:fashion_top/screen/products/product_widgets.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final TextEditingController productName = TextEditingController();
// String? txtUpdateProductName;

FirebaseDatabase db = FirebaseDatabase.instance;

productSimpleDialogs(
  context,
  String addEdit,
  ProductModel data,
  String btn,
  Function() onRefresh,
) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      title: Text(
        addProductDetail,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Color.fromRGBO(215, 215, 215, 1),
            ),
            textFormFields(
              label: lblProductName,
              keyBoardType: TextInputType.text,
              txtController: productName..text = data.productName,
              hintTexts: addProductName,
              borderColor: borderColorBlack,
              borderRadius: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, top: 10.0),
              child: MaterialButton(
                height: 40.0,
                minWidth: 230.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: appFromClr,
                onPressed: () {
                  if (addEdit == 'edit') {
                    db.ref('Product').child(data.key).update({
                      'productName': productName.text,
                      // 'schoolName': schoolName.text,
                      // 'schoolContactPerson': schoolContactPerson.text,
                      // 'schoolContact': schoolContactNumber.text,
                      // 'schoolAddress': schoolAddress.text,
                      // 'schoolPinCode': schoolPinCode.text,
                      'key': data.key,
                    });
                  } else {
                    String? key = db.ref().push().key;
                    db.ref('Product').child(key!).set({
                      'productName': productName.text,
                      // 'schoolName': schoolName.text,
                      // 'schoolContactPerson': schoolContactPerson.text,
                      // 'schoolContact': schoolContactNumber.text,
                      // 'schoolAddress': schoolAddress.text,
                      // 'schoolPinCode': schoolPinCode.text,
                      'key': key,
                    });
                  }
                  // setState(() {
                  //   productData.add(
                  //     ProductModel(
                  //       productName: productName.text,
                  //     ),
                  //   );
                  // });
                  // String? key = db.ref().push().key;
                  // db.ref('Product Detail').child(key!).set({
                  //   'productName': productName.text,
                  //   'key':key,
                  // });
                  productName.clear();
                  onRefresh();
                  Navigator.pop(context);
                  // productDetails();
                },
                child: Text(btn,
                    style: TextStyle(
                        color: btnTextWhite, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ],
    ),
  );
}
