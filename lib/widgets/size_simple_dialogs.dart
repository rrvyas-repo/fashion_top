// import 'package:fashion_top/models/product_model.dart';
// import 'package:fashion_top/models/size_model.dart';
// import 'package:fashion_top/screen/sizes/size.dart';
// import 'package:fashion_top/screen/sizes/size_widgets.dart';
// import 'package:fashion_top/utils/colors.dart';
// import 'package:fashion_top/utils/string.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// List<DropdownMenuItem<ProductModel>>? dropDownMenuItems;
// ProductModel? selectedItem;
//
// @override
// void initState() {
//   initState();
//   dropDownMenuItems = buildDropDownMenuItem(productData);
//   selectedItem = dropDownMenuItems![0].value;
// }
//
// List<DropdownMenuItem<ProductModel>> buildDropDownMenuItem(List listItems) {
//   List<DropdownMenuItem<ProductModel>> items = [];
//   for (ProductModel listItem in listItems) {
//     items.add(DropdownMenuItem(
//         child: Text(listItem.productName.toString()), value: listItem));
//     //  print(listItem.productName);
//   }
//   return items;
// }
//
// final TextEditingController sizesCon = TextEditingController();
// FirebaseDatabase db = FirebaseDatabase.instance;
//
// sizeSimpleDialogs(
//   context,
//   String addEdit,
//   SizeModel data,
// String btn,
//     Function() onRefresh,
// ) {
//   return showDialog(
//     context: context,
//     builder: (context) => SimpleDialog(
//       title: const Text(addSize),
//       children: [
//         Column(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 28.0, right: 20.0),
//               child: StatefulBuilder(
//                 builder: (context, setState) => DropdownButton(
//                   isExpanded: true,
//                   items: dropDownMenuItems,
//                   value: selectedItem,
//                   onChanged: (value) => setState(() {
//                     selectedItem = value! as ProductModel;
//                   }),
//                 ),
//               ),
//             ),
//             textFormFields(
//               label: lblSize,
//               txtController: sizesCon..text = data.sizes as String,
//               borderColor: borderColorBlack,
//               borderRadius: 10.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 23.0, top: 10.0),
//               child: MaterialButton(
//                 height: 40.0,
//                 minWidth: 230.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 color: appFromClr,
//                 child: Text(btnAddSize,
//                     style: GoogleFonts.nunito(
//                         color: btnTextWhite, fontWeight: FontWeight.bold)
//
//                     // style: TextStyle(color: btnTextWhite),
//                     ),
//                 onPressed: () {
//                   if (addEdit == 'edit') {
//                     db.ref('Size').child(data.key).update({
//                       'dropDown': selectedItem,
//                       'sizeName': sizesCon.text,
//                       // 'schoolName': schoolName.text,
//                       // 'schoolContactPerson': schoolContactPerson.text,
//                       // 'schoolContact': schoolContactNumber.text,
//                       // 'schoolAddress': schoolAddress.text,
//                       // 'schoolPinCode': schoolPinCode.text,
//                       'key': data.key,
//                     });
//                   } else {
//                     String? key = db.ref().push().key;
//                     db.ref('Size').child(key!).set({
//                       'dropDown': selectedItem,
//                       'sizeName': sizesCon.text,
//                       // 'schoolName': schoolName.text,
//                       // 'schoolContactPerson': schoolContactPerson.text,
//                       // 'schoolContact': schoolContactNumber.text,
//                       // 'schoolAddress': schoolAddress.text,
//                       // 'schoolPinCode': schoolPinCode.text,
//                       'key': key,
//                     });
//                   }
//                   sizesCon.clear();
//                   // schoolName.clear();
//                   // schoolContactPerson.clear();
//                   // schoolContactNumber.clear();
//                   // schoolAddress.clear();
//                   // schoolPinCode.clear();
//                   // setState(() {
//                   //   bool already = false;
//                   //   sizeData.forEach((element) {
//                   //     if (element.product ==
//                   //         selectedItem!.productName
//                   //             .toString()) {
//                   //       already = true;
//                   //       element.sizes!
//                   //           .add(txtSizes.text);
//                   //     }
//                   //   });
//                   //   if (!already) {
//                   //     sizeData.where((element) => false);
//                   //     sizeData.add(
//                   //       SizeModel(
//                   //         product: selectedItem!.productName
//                   //             .toString(),
//                   //         sizes: [txtSizes.text],
//                   //       ),
//                   //     );
//                   //   }
//                   //   txtSizes.clear();
//                   // });
//                   Navigator.pop(context);
//                   // sizeDetails();
//                 },
//               ),
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
