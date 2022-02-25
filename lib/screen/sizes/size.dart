import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/models/product_model.dart';
import 'package:fashion_top/models/size_model.dart';
import 'package:fashion_top/screen/sizes/size_widgets.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SizeList extends StatefulWidget {
  const SizeList({Key? key}) : super(key: key);

  @override
  _SizeListState createState() => _SizeListState();
}

class _SizeListState extends State<SizeList> {
  FirebaseDatabase db = FirebaseDatabase.instance;

  TextEditingController txtSizes = TextEditingController();
  String? txtUpdateSizes;

  List<DropdownMenuItem<ProductModel>>? dropDownMenuItems;
  ProductModel? selectedItem;

  getSizes() {
    db.ref('Product').once().then((value) {
      productData.clear();
      Map temp = value.snapshot.value as Map;
      temp.forEach((key, value) {
        productData.add(
          ProductModel(
            key: key,
            productName: value['productName'],
          ),
        );
      });
      dropDownMenuItems = buildDropDownMenuItem(productData);
      selectedItem = dropDownMenuItems![0].value;
      db.ref('Size').once().then((value) {
        sizeData.clear();
        Map temp = value.snapshot.value as Map;
        temp.forEach((key, value) {
          sizeData.add(
            SizeModel(
              key: key,
              sizes: value['size'] ?? [],
              product: value['productName'] ?? '',
            ),
          );
        });
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSizes();
  }

  List<DropdownMenuItem<ProductModel>> buildDropDownMenuItem(List listItems) {
    List<DropdownMenuItem<ProductModel>> items = [];
    for (ProductModel listItem in listItems) {
      items.add(DropdownMenuItem(
          child: Text(listItem.productName.toString()), value: listItem));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // print('---------- $sizeData');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            icArrowBack,
            color: black,
          ),
        ),
        title: txt(
            textValue: appBarSize, color: black, fontWeight: FontWeight.bold),
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: sizeData.isNotEmpty
                  ? ListView.builder(
                      itemCount: sizeData.length,
                      itemBuilder: (context, index) => sizeData[index]
                              .sizes
                              .isNotEmpty
                          ? ExpansionTile(
                              title: Text(sizeData[index].product),
                              children: [
                                for (int i = 0;
                                    i < sizeData[index].sizes.length;
                                    i++)
                                  ListTile(
                                    title: Text(
                                        sizeData[index].sizes[i].toString()),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        db
                                            .ref('Size')
                                            .child(sizeData[index].key)
                                            .child('size')
                                            .child(i.toString())
                                            .remove()
                                            .then((value) {
                                          db
                                              .ref('Size')
                                              .child(sizeData[index].key)
                                              .child('size')
                                              .once()
                                              .then((value) {
                                            List sizes = [];
                                            print(value.snapshot.value);
                                            if (value.snapshot.value != null) {
                                              List data =
                                                  value.snapshot.value as List;
                                              print(data);
                                              data.forEach((element) {
                                                if (element.toString() !=
                                                    'null') {
                                                  sizes.add(element);
                                                } else {}
                                              });
                                            }
                                            //print('for mr'+ sizeData.toString());
                                            setState(() {
                                              sizeData.forEach((element) {
                                                print(element);
                                              });
                                            });
                                            db
                                                .ref('Size')
                                                .child(sizeData[index].key)
                                                .child('size')
                                                .set(sizes)
                                                .then((value) {
                                              getSizes();
                                            });
                                          });
                                        });
                                      },
                                    ),
                                  ),
                              ],
                            )
                          : SizedBox(),
                    )
                  : const Center(
                      child: Text(
                        listOfSize,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            Expanded(
              flex: 1,
              child: MaterialButton(
                color: appFromClr,
                height: 50.0,
                onPressed: () {
                  txtSizes.clear();
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text(addSize),
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, right: 20.0),
                              child: StatefulBuilder(
                                builder: (context, setState) => DropdownButton(
                                  isExpanded: true,
                                  items: dropDownMenuItems,
                                  value: selectedItem,
                                  onChanged: (value) => setState(() {
                                    selectedItem = value! as ProductModel;
                                  }),
                                ),
                              ),
                            ),
                            textFormFields(
                              label: lblSize,
                              txtController: txtSizes,
                              borderColor: borderColorBlack,
                              borderRadius: 10.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 23.0, top: 10.0),
                              child: MaterialButton(
                                height: 40.0,
                                minWidth: 230.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: appFromClr,
                                child: const Text(btnAddSize,
                                    style: TextStyle(
                                        color: btnTextWhite,
                                        fontWeight: FontWeight.bold)
                                    // style: TextStyle(color: btnTextWhite),
                                    ),
                                onPressed: () {
                                  // Navigator.pop(context);

                                  db
                                      .ref('Size')
                                      .child(selectedItem!.key)
                                      .child('size')
                                      .once()
                                      .then((value) {
                                    List m = [];
                                    print('+++++${value.snapshot.value}');
                                    if (value.snapshot.value != null) {
                                      m.addAll(value.snapshot.value as List);

                                      m = m.toList();
                                    }

                                    print('----${m}');
                                    if (m.isEmpty) {
                                      db
                                          .ref('Size')
                                          .child(selectedItem!.key)
                                          .set({
                                        'productName':
                                            selectedItem!.productName,
                                        'size': {0: txtSizes.text}
                                      });
                                    } else {
                                      db
                                          .ref('Size')
                                          .child(selectedItem!.key)
                                          .child('size')
                                          .update({
                                        m.length.toString(): txtSizes.text
                                      });
                                    }
                                    // print(txtSizes.text);
                                  });
                                  setState(() {
                                    bool already = false;
                                    sizeData.forEach((element) {
                                      if (element.product ==
                                          selectedItem!.productName
                                              .toString()) {
                                        already = true;
                                        element.sizes = element.sizes.toList();
                                        element.sizes.add(txtSizes.text);
                                      }
                                    });
                                    if (!already) {
                                      sizeData.where((element) => false);
                                      sizeData.add(
                                        SizeModel(
                                          product: selectedItem!.productName
                                              .toString(),
                                          sizes: [txtSizes.text],
                                          key: selectedItem!.key,
                                        ),
                                      );
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconAdd,
                      color: btnIconWhite,
                    ),
                    const Text(
                      btnAddSize,
                      style: TextStyle(
                        color: btnTextWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:fashion_top/common/texts.dart';
// import 'package:fashion_top/models/product_model.dart';
// import 'package:fashion_top/models/size_model.dart';
// import 'package:fashion_top/screen/sizes/size_widgets.dart';
// import 'package:fashion_top/utils/colors.dart';
// import 'package:fashion_top/utils/icons.dart';
// import 'package:fashion_top/utils/string.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//
// class SizeList extends StatefulWidget {
//   const SizeList({Key? key}) : super(key: key);
//
//   @override
//   _SizeListState createState() => _SizeListState();
// }
//
// class _SizeListState extends State<SizeList> {
//   FirebaseDatabase db = FirebaseDatabase.instance;
//
//   TextEditingController txtSizes = TextEditingController();
//   String? txtUpdateSizes;
//
//   List<DropdownMenuItem<ProductModel>>? dropDownMenuItems;
//   ProductModel? selectedItem;
//
//   getSizes() {
//     db.ref('Product').once().then((value) {
//       productData.clear();
//       Map temp = value.snapshot.value as Map;
//       temp.forEach((key, value) {
//         productData.add(
//           ProductModel(
//             key: key,
//             productName: value['productName'],
//           ),
//         );
//       });
//       dropDownMenuItems = buildDropDownMenuItem(productData);
//       selectedItem = dropDownMenuItems![0].value;
//       db.ref('Size').once().then((value) {
//         sizeData.clear();
//         Map temp = value.snapshot.value as Map;
//         temp.forEach((key, value) {
//           sizeData.add(
//             SizeModel(
//               key: key,
//               sizes: value['size'],
//               product: value['productName'],
//             ),
//           );
//         });
//         setState(() {});
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getSizes();
//   }
//
//   List<DropdownMenuItem<ProductModel>> buildDropDownMenuItem(List listItems) {
//     List<DropdownMenuItem<ProductModel>> items = [];
//     for (ProductModel listItem in listItems) {
//       items.add(DropdownMenuItem(
//           child: Text(listItem.productName.toString()), value: listItem));
//     }
//     return items;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print('---------- $sizeData');
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             icArrowBack,
//             color: black,
//           ),
//         ),
//         title: txt(
//             // fontSize: 0.0,
//             textValue: appBarSize,
//             color: black,
//             fontWeight: FontWeight.bold),
//         elevation: 0.0,
//         backgroundColor: white,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 9,
//               child: sizeData.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: sizeData.length,
//                       itemBuilder: (context, index) => ExpansionTile(
//                         title: Text(sizeData[index].product),
//                         children: [
//                           for (int i = 0; i < sizeData[index].sizes.length; i++)
//                             ListTile(
//                               title: Text(sizeData[index].sizes[i].toString()),
//                               trailing: IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 onPressed: () {
//                                   db
//                                       .ref('Size')
//                                       .child(sizeData[index].key)
//                                       .child('size')
//                                       .child(i.toString())
//                                       .remove()
//                                       .then((value) {
//                                     db
//                                         .ref('Size')
//                                         .child(sizeData[index].key)
//                                         .child('size')
//                                         .once()
//                                         .then((value) {
//                                       List sizes = [];
//                                       List data = value.snapshot.value as List;
//                                       data.forEach((element) {
//                                         if (element.toString() != 'null')
//                                           sizes.add(element);
//                                       });
//                                       //print('for mr'+ sizeData.toString());
//                                       setState(() {
//                                         sizeData.forEach((element) {
//                                           print(element);
//                                         });
//                                       });
//                                       db
//                                           .ref('Size')
//                                           .child(sizeData[index].key)
//                                           .child('size')
//                                           .set(sizes)
//                                           .then((value) {
//                                         getSizes();
//                                       });
//                                     });
//                                   });
//                                 },
//                               ),
//                             ),
//                         ],
//                       ),
//                     )
//                   : const Center(
//                       child: Text(
//                         listOfSize,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//             ),
//             Expanded(
//               flex: 1,
//               child: MaterialButton(
//                 color: appFromClr,
//                 height: 50.0,
//                 onPressed: () {
//                   txtSizes.clear();
//                   showDialog(
//                     context: context,
//                     builder: (context) => SimpleDialog(
//                       title: const Text(addSize),
//                       children: [
//                         Column(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 28.0, right: 20.0),
//                               child: StatefulBuilder(
//                                 builder: (context, setState) => DropdownButton(
//                                   isExpanded: true,
//                                   items: dropDownMenuItems,
//                                   value: selectedItem,
//                                   onChanged: (value) => setState(() {
//                                     selectedItem = value! as ProductModel;
//                                   }),
//                                 ),
//                               ),
//                             ),
//                             textFormFields(
//                               label: lblSize,
//                               txtController: txtSizes,
//                               borderColor: borderColorBlack,
//                               borderRadius: 10.0,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 23.0, top: 10.0),
//                               child: MaterialButton(
//                                 height: 40.0,
//                                 minWidth: 230.0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 color: appFromClr,
//                                 child: const Text(btnAddSize,
//                                     style: TextStyle(
//                                         color: btnTextWhite,
//                                         fontWeight: FontWeight.bold)
//                                     // style: TextStyle(color: btnTextWhite),
//                                     ),
//                                 onPressed: () {
//                                   // Navigator.pop(context);
//
//                                   db
//                                       .ref('Size')
//                                       .child(selectedItem!.key)
//                                       .child('size')
//                                       .once()
//                                       .then((value) {
//                                     List m = [];
//                                     print('+++++${value.snapshot.value}');
//                                     if (value.snapshot.value != null) {
//                                       m.addAll(value.snapshot.value as List);
//
//                                       m = m.toList();
//                                     }
//
//                                     print('----${m}');
//                                     if (m.isEmpty) {
//                                       db
//                                           .ref('Size')
//                                           .child(selectedItem!.key)
//                                           .set({
//                                         'productName':
//                                             selectedItem!.productName,
//                                         'size': {0: txtSizes.text}
//                                       });
//                                     } else {
//                                       db
//                                           .ref('Size')
//                                           .child(selectedItem!.key)
//                                           .child('size')
//                                           .update({
//                                         m.length.toString(): txtSizes.text
//                                       });
//                                     }
//                                     // print(txtSizes.text);
//                                   });
//                                   setState(() {
//                                     bool already = false;
//                                     sizeData.forEach((element) {
//                                       if (element.product ==
//                                           selectedItem!.productName
//                                               .toString()) {
//                                         already = true;
//                                         element.sizes = element.sizes.toList();
//                                         element.sizes.add(txtSizes.text);
//                                       }
//                                     });
//                                     if (!already) {
//                                       sizeData.where((element) => false);
//                                       sizeData.add(
//                                         SizeModel(
//                                           product: selectedItem!.productName
//                                               .toString(),
//                                           sizes: [txtSizes.text],
//                                           key: selectedItem!.key,
//                                         ),
//                                       );
//                                     }
//                                   });
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       iconAdd,
//                       color: btnIconWhite,
//                     ),
//                     const Text(
//                       btnAddSize,
//                       style: TextStyle(
//                         color: btnTextWhite,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
