
import 'dart:async';

import 'package:fashion_top/models/product_model.dart';
import 'package:fashion_top/models/school_model.dart';
import 'package:fashion_top/models/size_model.dart';
import 'package:fashion_top/models/stocks_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  FirebaseDatabase db = FirebaseDatabase.instance;

  TextEditingController txtStocks = TextEditingController();
  String? txtUpdateStocks;

  List<DropdownMenuItem<SchoolModel>>? dropDownMenuItemsSchool;
  SchoolModel? selectedItemSchool;

  List<DropdownMenuItem<ProductModel>>? dropDownMenuItemsProduct;
  ProductModel? selectedItemProduct;

  List<DropdownMenuItem<SizeModel>>? dropDownMenuItemsSize;
  SizeModel? selectedItemSize;

  getSchool() {
    dropDownMenuItemsSchool = buildDropDownMenuItemSchool(schoolData);
    selectedItemSchool = dropDownMenuItemsSchool![0].value;
  }

  getProduct() {
    dropDownMenuItemsProduct = buildDropDownMenuItemProduct(productData);
    selectedItemProduct = dropDownMenuItemsProduct![0].value;
  }

  //
  getSize() {
    dropDownMenuItemsSize = buildDropDownMenuItemSize(sizeData);
    selectedItemSize = dropDownMenuItemsSize![0].value;
  }

  @override
  void initState() {
    // super.initState();
    // getStocks();
    getSchool();
    getProduct();
    getSize();
    super.initState();
  }

  String shop = 'Shop', godown = 'Godown', stock = 'Shop';
  Stock stockObj = Stock();

  String boys = 'Boys';
  String girls = 'Girls';
  String gender = 'gender';

  // String boys = 'boys', gender = 'girls', girls = 'girls';
  // Gender genderObj = Gender();
  int _counter = 0;

  // TextEditingController dropdown = TextEditingController();

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  List<DropdownMenuItem<SchoolModel>> buildDropDownMenuItemSchool(
      List listItems) {
    List<DropdownMenuItem<SchoolModel>> items = [];
    for (SchoolModel listItem in listItems) {
      items.add(DropdownMenuItem(
          child: Text(listItem.schoolName.toString()), value: listItem));
    }
    return items;
  }

  List<DropdownMenuItem<ProductModel>> buildDropDownMenuItemProduct(
      List listItems) {
    List<DropdownMenuItem<ProductModel>> items = [];
    for (ProductModel listItem in listItems) {
      items.add(DropdownMenuItem(
          child: Text(listItem.productName.toString()), value: listItem));
    }
    return items;
  }

  List<DropdownMenuItem<SizeModel>> buildDropDownMenuItemSize(List listItems) {
    List<DropdownMenuItem<SizeModel>> items = [];
    for (SizeModel listItem in listItems) {
      items.add(DropdownMenuItem(
          child: Text(listItem.sizes.toString()), value: listItem));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child: MaterialButton(
    //       onPressed: () {
    //         showDialog(
    //           context: context,
    //           builder: (context) => StatefulBuilder(
    //             builder: (context, setState) => SimpleDialog(
    //               children: [
    //                 DropdownButton(
    //                   isExpanded: true,
    //                   items: dropDownMenuItems,
    //                   value: selectedItem,
    //                   onChanged: (value) => setState(() {
    //                     selectedItem = value! as SchoolModel;
    //                   }),
    //                 ),
    //
    //                 DropdownButton(
    //                   isExpanded: true,
    //                   items: dropDownMenuItemsProduct,
    //                   value: selectedItemProduct,
    //                   onChanged: (value) => setState(() {
    //                     selectedItemProduct = value! as ProductModel;
    //                   }),
    //                 ),
    //
    //                 DropdownButton(
    //                   isExpanded: true,
    //                   items: dropDownMenuItemsSize,
    //                   value: selectedItemSize,
    //                   onChanged: (value) => setState(() {
    //                     selectedItemSize = value! as SizeModel;
    //                   }),
    //                 ),
    //
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //       child: const Text('ShowDialogue'),
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                // Expanded(
                //   child: ListView.builder(
                //     itemBuilder: (context, index) {
                //       return Container(
                //         child: Text(
                //           stocks[index].school.toString(),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Expanded(
                //       flex: 6,
                //       child: DropdownButton(
                //         isExpanded: true,
                //         items: dropDownMenuItems,
                //         value: selectedItem,
                //         onChanged: (value) =>
                //             setState(() {
                //               selectedItem = value! as SchoolModel;
                //             }),
                //       ),
                //     ),
                //     Expanded(
                //       flex: 4,
                //       child: Padding(
                //         padding: const EdgeInsets.fromLTRB(14.0, 0, 0, 0),
                //         child: MaterialButton(
                //           onPressed: () {},
                //           child: const Text(
                //             'SEARCH',
                //             style: TextStyle(
                //               color: Colors.white,
                //             ),
                //           ),
                //           color: const Color.fromRGBO(157, 55, 67, 1),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(3.0),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                StreamBuilder(
                  stream: stockObj.stockStream,
                  builder: (context, snapshot) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: shop,
                              groupValue:
                              snapshot.hasData ? snapshot.data : stock,
                              onChanged: (value) {
                                stockObj.setData(value);
                              }),
                          const Text('Shop'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: godown,
                              groupValue:
                              snapshot.hasData ? snapshot.data : stock,
                              onChanged: (gender) {
                                stockObj.setData(gender);
                              }),
                          const Text('Godown'),
                        ],
                      ),
                    ],
                  ),
                ),

                // const SizedBox(
                //   child: Image(
                //     image: NetworkImage(
                //         'https://media.istockphoto.com/photos/school-uniform-store-picture-id1171503529?k=20&m=1171503529&s=612x612&w=0&h=YLxsw1Wo5mCzeL8_n9Y5B2LAFUg8nrUeNToUa4tkrDk='),
                //     height: 400.0,
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                      itemCount: stocksData.length,
                      itemBuilder: (context, index) {
                        // String item = stockData[index].toString();
                        return Container(
                          child: Column(
                            children: [
                              Text(stocksData[index].school.toString()),
                            ],
                          ),
                        );
                      }),
                ),
                //   // Container(
                //   //   child: ,
                //   // ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MaterialButton(
                        child: const Text(
                          'ADD STOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height: 60.0,
                        minWidth: 150.0,
                        color: const Color.fromRGBO(157, 55, 67, 1),
                        // minWidth: 50.0,
                        onPressed: () {
                          // txtStocks.clear();
                          showDialog(
                            context: context,
                            builder: (context) =>
                            // StatefulBuilder(
                            //   builder: (context, setState) =>
                            SimpleDialog(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: StatefulBuilder(
                                    builder: (context, setState) => Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          'SCHOOL : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        DropdownButton(
                                          isExpanded: true,
                                          items: dropDownMenuItemsSchool,
                                          value: selectedItemSchool,
                                          onChanged: (value) => setState(() {
                                            selectedItemSchool =
                                            value! as SchoolModel;
                                          }),
                                        ),

                                        const Text(
                                          'PRODUCT : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        DropdownButton(
                                          isExpanded: true,
                                          items: dropDownMenuItemsProduct,
                                          value: selectedItemProduct,
                                          onChanged: (value) => setState(() {
                                            selectedItemProduct =
                                            value! as ProductModel;
                                          }),
                                        ),
                                        const Text(
                                          'SIZE : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        DropdownButton(
                                          items: dropDownMenuItemsSize,
                                          isExpanded: true,
                                          value: selectedItemSize,
                                          onChanged: (value) => setState(() {
                                            selectedItemSize =
                                            value! as SizeModel;
                                          }),
                                        ),
                                        const Text(
                                          'GENDER : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Boy',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Radio(
                                              value: boys,
                                              groupValue: gender,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  gender = value!;
                                                });
                                              },
                                            ),
                                            const Text(
                                              'Girl',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Radio(
                                              value: girls,
                                              groupValue: gender,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  gender = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),

                                        const Text(
                                          'QUANTITY: ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //Counter
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        157, 55, 67, 1),
                                                  ),
                                                ),
                                                onPressed: () => setState(() {
                                                  _counter++;
                                                }),
                                                child: const Icon(Icons.add),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText: '$_counter',
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 25.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromRGBO(
                                                          157, 55, 67, 1)),
                                                ),
                                                onPressed: () => setState(() {
                                                  _counter == 0
                                                      ? _counter = 0
                                                      : _counter--;
                                                }),
                                                child: const Icon(Icons.remove),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    stocksData.add(
                                      StockQuantity(
                                        school: '',
                                        product: '',
                                        // sizes: '',
                                        // quanty: '',
                                        // key: '',
                                        size: [],
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => add()));
                                  },
                                  child: const Text(
                                    'ADD',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: const Color.fromRGBO(157, 55, 67, 1),
                                ),
                              ],
                            ),
                          );
                        }),
                    MaterialButton(
                        child: const Text(
                          'DEDUCT STOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        height: 60.0,
                        minWidth: 150.0,
                        color: Colors.cyan.shade800,
                        // color: const Color.fromRGBO(157, 55, 67, 1),
                        // minWidth: 50.0,
                        onPressed: () {
                          txtStocks.clear();
                          showDialog(
                            context: context,
                            builder: (context) =>
                            // StatefulBuilder(
                            //   builder: (context, setState) =>
                            SimpleDialog(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: StatefulBuilder(
                                    builder: (context, setState) => Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Text(
                                          'SCHOOL : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        DropdownButton(
                                          isExpanded: true,
                                          items: dropDownMenuItemsSchool,
                                          value: selectedItemSchool,
                                          onChanged: (value) => setState(() {
                                            selectedItemSchool =
                                            value! as SchoolModel;
                                          }),
                                        ),

                                        const Text(
                                          'PRODUCT : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        DropdownButton(
                                          isExpanded: true,
                                          items: dropDownMenuItemsProduct,
                                          value: selectedItemProduct,
                                          onChanged: (value) => setState(() {
                                            selectedItemProduct =
                                            value! as ProductModel;
                                          }),
                                        ),
                                        const Text(
                                          'SIZE : ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        DropdownButton(
                                          items: dropDownMenuItemsSize,
                                          isExpanded: true,
                                          value: selectedItemSize,
                                          onChanged: (value) => setState(() {
                                            selectedItemSize =
                                            value! as SizeModel;
                                          }),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'GENDER : ',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              'Boy',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Radio(
                                              value: boys,
                                              groupValue: gender,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  gender = value!;
                                                });
                                              },
                                            ),
                                            const Text(
                                              'Girl',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Radio(
                                              value: girls,
                                              groupValue: gender,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  gender = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          'QUANTITY: ',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //Counter
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        157, 55, 67, 1),
                                                  ),
                                                ),
                                                onPressed: () => setState(() {
                                                  _counter++;
                                                }),
                                                child: const Icon(Icons.add),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: '$_counter',
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 25.0,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                  MaterialStateProperty.all(
                                                    // Colors.cyan.shade800,
                                                    const Color.fromRGBO(
                                                        157, 55, 67, 1),
                                                  ),
                                                ),
                                                onPressed: () => setState(() {
                                                  _counter == 0
                                                      ? _counter = 0
                                                      : _counter--;
                                                }),
                                                child: const Icon(Icons.remove),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) => StockList(),),);
                                  },
                                  child: const Text(
                                    'DEDUCT',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.cyan.shade800,
                                  // color: const Color.fromRGBO(157, 55, 67, 1),
                                ),
                              ],
                            ),
                          );
                        }),

// deduct
                    //DEDUCT
                    // MaterialButton(
                    //   child: const Text(
                    //     'DEDUCT STOCK',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   color: Colors.cyan.shade800,
                    //   height: 60.0,
                    //   minWidth: 150.0,
                    //   onPressed: () => showDialog(
                    //     context: context,
                    //     builder: (context) => StatefulBuilder(
                    //       builder: (context, setState) => SimpleDialog(
                    //         children: [
                    //           Column(
                    //             children: [
                    //               const Text(
                    //                 'SCHOOL : ',
                    //                 style: TextStyle(
                    //                   fontSize: 18.0,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               DropdownButton(
                    //                 isExpanded: true,
                    //                 value: dropDownValue,
                    //                 icon: const Icon(Icons.keyboard_arrow_down),
                    //                 items: items.map((String items) {
                    //                   return DropdownMenuItem(
                    //                     value: items,
                    //                     child: Text(items),
                    //                     alignment: Alignment.center,
                    //                   );
                    //                 }).toList(),
                    //                 onChanged: (String? newValue) {
                    //                   setState(() {
                    //                     dropDownValue = newValue!;
                    //                   });
                    //                 },
                    //               ),
                    //               const Text(
                    //                 'PRODUCT : ',
                    //                 style: TextStyle(
                    //                   fontSize: 18.0,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               DropdownButton(
                    //                 isExpanded: true,
                    //                 value: prod,
                    //                 icon: const Icon(Icons.keyboard_arrow_down),
                    //                 items: products.map((String products) {
                    //                   return DropdownMenuItem(
                    //                     value: products,
                    //                     child: Text(products),
                    //                     alignment: Alignment.center,
                    //                   );
                    //                 }).toList(),
                    //                 onChanged: (String? newValue) {
                    //                   setState(() {
                    //                     prod = newValue!;
                    //                   });
                    //                 },
                    //               ),
                    //               const Text(
                    //                 'SIZE : ',
                    //                 style: TextStyle(
                    //                   fontSize: 18.0,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               DropdownButton(
                    //                 isExpanded: true,
                    //                 value: siz,
                    //                 icon: const Icon(Icons.keyboard_arrow_down),
                    //                 items: sizes.map((String sizes) {
                    //                   return DropdownMenuItem(
                    //                     value: sizes,
                    //                     child: Text(sizes),
                    //                     alignment: Alignment.center,
                    //                   );
                    //                 }).toList(),
                    //                 onChanged: (String? newValue) {
                    //                   setState(() {
                    //                     siz = newValue!;
                    //                   });
                    //                 },
                    //               ),
                    //               const Text(
                    //                 'GENDER : ',
                    //                 style: TextStyle(
                    //                   fontSize: 18.0,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   Radio(
                    //                     value: boys,
                    //                     groupValue: gender,
                    //                     onChanged: (value) => setState(() {
                    //                       gender = boys;
                    //                     }),
                    //                   ),
                    //                   const Text(
                    //                     'BOYS: ',
                    //                   ),
                    //                   Radio(
                    //                     value: girls,
                    //                     groupValue: gender,
                    //                     onChanged: (value) => setState(() {
                    //                       gender = girls;
                    //                     }),
                    //                   ),
                    //                   const Text(
                    //                     'GIRLS',
                    //                   ),
                    //                 ],
                    //               ),
                    //               //Counter
                    //               Row(
                    //                 children: [
                    //                   Expanded(
                    //                     flex: 3,
                    //                     child: ElevatedButton(
                    //                       style: ButtonStyle(
                    //                         backgroundColor:
                    //                             MaterialStateProperty.all(
                    //                           const Color.fromRGBO(
                    //                               157, 55, 67, 1),
                    //                         ),
                    //                       ),
                    //                       onPressed: () => setState(() {
                    //                         _counter++;
                    //                       }),
                    //                       child: const Icon(Icons.add),
                    //                     ),
                    //                   ),
                    //                   Expanded(
                    //                     flex: 4,
                    //                     child: TextFormField(
                    //                       decoration: InputDecoration(
                    //                         hintText: '$_counter',
                    //                       ),
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .headline4,
                    //                     ),
                    //                   ),
                    //                   Expanded(
                    //                     flex: 3,
                    //                     child: ElevatedButton(
                    //                       style: ButtonStyle(
                    //                         backgroundColor:
                    //                             MaterialStateProperty.all(
                    //                                 const Color.fromRGBO(
                    //                                     157, 55, 67, 1)),
                    //                       ),
                    //                       onPressed: () => setState(() {
                    //                         _counter == 0
                    //                             ? _counter = 0
                    //                             : _counter--;
                    //                       }),
                    //                       child: const Icon(Icons.remove),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //           MaterialButton(
                    //             onPressed: () {
                    //               // Navigator.push(
                    //               //     context,
                    //               //     MaterialPageRoute(
                    //               //         builder: (context) => add()));
                    //             },
                    //             child: const Text(
                    //               'DEDUCT',
                    //               style: TextStyle(
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //             color: const Color.fromRGBO(157, 55, 67, 1),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
              // SizedBox(
              //   height: 30.0,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

class Stock {
  final StreamController controller = StreamController();

  get stockStream => controller.stream;

  get stockSink => controller.sink;

  // StreamController<bool> controller1 = StreamController();
  //
  // Stream<bool> get demoStream1 => controller.stream;
  //
  // Sink<bool> get demoSink1 => controller.sink;

  setData(value) {
    stockSink.add(value);
  }
}

// DataTable(
// columnSpacing: 57,
// dividerThickness: 2,
// columns: [
// // for(int i=0; i < sizes.length; i++)
// DataColumn(label: const Text('data')),
// DataColumn(label: Text('data')),
// DataColumn(label: Text('data')),
// DataColumn(label: Text('data')),
// DataColumn(label: Text('data')),
// // DataColumn(label: Text('data')),
// // DataColumn(label: Text('data')),
// // DataColumn(label: Text('data')),
// // DataColumn(label: Text('data')),
// // DataColumn(label: Text('data')),
// ], rows: [
// DataRow(cells: <DataCell>[DataCell(Text('1'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),],),
// DataRow(cells: <DataCell>[DataCell(Text('1'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),],),
// DataRow(cells: <DataCell>[DataCell(Text('1'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),],),
// DataRow(cells: <DataCell>[DataCell(Text('1'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),],),
// DataRow(cells: <DataCell>[DataCell(Text('1'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),],),
// DataRow(cells: <DataCell>[DataCell(Text('1'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),DataCell(Text('2'),),],),
// // DataRow(cells: <DataCell>[DataCell(Text('1'),),],),
// // DataRow(cells: <DataCell>[DataCell(Text('1'),),],),
// // DataRow(cells: <DataCell>[DataCell(Text('1'),),],),
// // DataRow(cells: <DataCell>[DataCell(Text('1'),),],),
// // DataRow(cells: <DataCell>[DataCell(Text('1'),),],),
// // DataCell(Text(schoolName[index]['schoolName'].toString(),),)
// ]),



// import 'dart:async';
//
// import 'package:fashion_top/models/product_model.dart';
// import 'package:fashion_top/models/school_model.dart';
// import 'package:fashion_top/models/size_model.dart';
// import 'package:flutter/material.dart';
//
// class Stocks extends StatefulWidget {
//   const Stocks({Key? key}) : super(key: key);
//
//   @override
//   _StocksState createState() => _StocksState();
// }
//
// class _StocksState extends State<Stocks> {
//   String shop = 'Shop', godown = 'Godown', stock = 'Shop';
//   Demo demoobj = Demo();
//
//   List<DropdownMenuItem<SchoolModel>>? dropDownMenuItems;
//   SchoolModel? selectedItem;
//
//   List<DropdownMenuItem<ProductModel>>? dropDownMenuItemsProduct;
//   ProductModel? selectedItemProduct;
//
//   List<DropdownMenuItem<SizeModel>>? dropDownMenuItemsSize;
//   SizeModel? selectedItemSize;
//
//   getSchool() {
//     dropDownMenuItems = buildDropDownMenuItemSchool(schoolData);
//     selectedItem = dropDownMenuItems![0].value;
//   }
//
//   getProduct() {
//     dropDownMenuItemsProduct = buildDropDownMenuItemProduct(productData);
//     selectedItemProduct = dropDownMenuItemsProduct![0].value;
//   }
//
//   getSize() {
//     dropDownMenuItemsSize = buildDropDownMenuItemSize(sizeData);
//     selectedItemSize = dropDownMenuItemsSize![0].value;
//   }
//
//   String dropDownValue = 'School1';
//   String prod = 'Tie';
//   String siz = '10';
//   String boys = 'boys';
//   String gender = '';
//   String girls = 'girls';
//   int _counter = 0;
//   var items = [
//     'School1',
//     'School2',
//     'School3',
//     'School4',
//     'School5',
//   ];
//   var products = [
//     'Shirt',
//     'Tie',
//     'Shoes',
//     'Kurtis',
//     'Dupatta',
//     'Socks',
//     'Pants',
//     'Dress',
//     'Belt',
//     'Socks',
//     'T-Shirt',
//     'Shoes',
//     ''
//   ];
//   var sizes = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9',
//     '10',
//   ];
//   TextEditingController dropdown = TextEditingController();
//
//   void incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   void decrementCounter() {
//     setState(() {
//       _counter--;
//     });
//   }
//
//   List<DropdownMenuItem<SchoolModel>> buildDropDownMenuItemSchool(
//       List listItems) {
//     List<DropdownMenuItem<SchoolModel>> items = [];
//     for (SchoolModel listItem in listItems) {
//       items.add(DropdownMenuItem(
//           child: Text(listItem.schoolName.toString()), value: listItem));
//     }
//     return items;
//   }
//
//
//   List<DropdownMenuItem<ProductModel>> buildDropDownMenuItemProduct(
//       List listItems) {
//     List<DropdownMenuItem<ProductModel>> items = [];
//     for (ProductModel listItem in listItems) {
//       items.add(DropdownMenuItem(
//           child: Text(listItem.productName.toString()), value: listItem));
//     }
//     return items;
//   }
//
//
//   List<DropdownMenuItem<SizeModel>> buildDropDownMenuItemSize(
//       List listItems) {
//     List<DropdownMenuItem<SizeModel>> items = [];
//     for (SizeModel listItem in listItems) {
//       items.add(DropdownMenuItem(
//           child: Text(listItem.sizes.toString()), value: listItem));
//     }
//     return items;
//   }
//
//   // @override
//   // void initState() {
//   //   getSchool();
//   //   getProduct();
//   //   // TODO: implement initState
//   //   super.initState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: MaterialButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => StatefulBuilder(
//                 builder: (context, setState) => SimpleDialog(
//                   children: [
//                     DropdownButton(
//                       isExpanded: true,
//                       items: dropDownMenuItems,
//                       value: selectedItem,
//                       onChanged: (value) => setState(() {
//                         selectedItem = value! as SchoolModel;
//                       }),
//                     ),
//
//                     DropdownButton(
//                       isExpanded: true,
//                       items: dropDownMenuItemsProduct,
//                       value: selectedItemProduct,
//                       onChanged: (value) => setState(() {
//                         selectedItemProduct = value! as ProductModel;
//                       }),
//                     ),
//
//                     DropdownButton(
//                       isExpanded: true,
//                       items: dropDownMenuItemsSize,
//                       value: selectedItemSize,
//                       onChanged: (value) => setState(() {
//                         selectedItemSize = value! as SizeModel;
//                       }),
//                     ),
//
//                   ],
//                 ),
//               ),
//             );
//           },
//           child: const Text('ShowDialogue'),
//         ),
//       ),
//     );
//     // return Scaffold(
//     //   body: SafeArea(
//     //     child: Expanded(
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(25.0),
//     //         child: Column(
//     //           children: [
//     //             // Expanded(
//     //             //   child: ListView.builder(
//     //             //     itemBuilder: (context, index) {
//     //             //       return Container(
//     //             //         child: Text(
//     //             //           stocks[index].school.toString(),
//     //             //         ),
//     //             //       );
//     //             //     },
//     //             //   ),
//     //             // ),
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //               children: [
//     //                 Expanded(
//     //                   flex: 6,
//     //                   child: DropdownButton(
//     //                     isExpanded: true,
//     //                     items: dropDownMenuItems,
//     //                     value: selectedItem,
//     //                     onChanged: (value) => setState(() {
//     //                       selectedItem = value! as SchoolModel;
//     //                     }),
//     //                   ),
//     //                 ),
//     //                 Expanded(
//     //                   flex: 4,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.fromLTRB(14.0, 0, 0, 0),
//     //                     child: MaterialButton(
//     //                       onPressed: () {},
//     //                       child: const Text(
//     //                         'SEARCH',
//     //                         style: TextStyle(
//     //                           color: Colors.white,
//     //                         ),
//     //                       ),
//     //                       color: const Color.fromRGBO(157, 55, 67, 1),
//     //                       shape: RoundedRectangleBorder(
//     //                         borderRadius: BorderRadius.circular(3.0),
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //             StreamBuilder(
//     //               stream: demoobj.demoStream,
//     //               builder: (context, snapshot) => Row(
//     //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //                 children: [
//     //                   Row(
//     //                     children: [
//     //                       Radio(
//     //                           value: shop,
//     //                           groupValue:
//     //                               snapshot.hasData ? snapshot.data : stock,
//     //                           onChanged: (value) {
//     //                             demoobj.setdata(value);
//     //                           }),
//     //                       const Text('Shop'),
//     //                     ],
//     //                   ),
//     //                   Row(
//     //                     children: [
//     //                       Radio(
//     //                           value: godown,
//     //                           groupValue:
//     //                               snapshot.hasData ? snapshot.data : stock,
//     //                           onChanged: (gender) {
//     //                             demoobj.setdata(gender);
//     //                           }),
//     //                       const Text('Godown'),
//     //                     ],
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //             const SizedBox(
//     //               child: Image(
//     //                 image: NetworkImage(
//     //                     'https://media.istockphoto.com/photos/school-uniform-store-picture-id1171503529?k=20&m=1171503529&s=612x612&w=0&h=YLxsw1Wo5mCzeL8_n9Y5B2LAFUg8nrUeNToUa4tkrDk='),
//     //                 height: 400.0,
//     //               ),
//     //             ),
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //               // crossAxisAlignment: CrossAxisAlignment.end,
//     //               mainAxisSize: MainAxisSize.max,
//     //               children: [
//     //                 MaterialButton(
//     //                   child: const Text(
//     //                     'ADD STOCK',
//     //                     style: TextStyle(
//     //                       color: Colors.white,
//     //                       fontWeight: FontWeight.bold,
//     //                     ),
//     //                   ),
//     //                   height: 60.0,
//     //                   minWidth: 150.0,
//     //                   color: const Color.fromRGBO(157, 55, 67, 1),
//     //                   // minWidth: 50.0,
//     //                   onPressed: () => showDialog(
//     //                     context: context,
//     //                     builder: (context) => StatefulBuilder(
//     //                       builder: (context, setState) => SimpleDialog(
//     //                         children: [
//     //                           Padding(
//     //                             padding: const EdgeInsets.all(25.0),
//     //                             child: Column(
//     //                               crossAxisAlignment: CrossAxisAlignment.start,
//     //                               mainAxisAlignment:
//     //                                   MainAxisAlignment.spaceEvenly,
//     //                               children: [
//     //                                 const Text(
//     //                                   'SCHOOL : ',
//     //                                   style: TextStyle(
//     //                                     fontSize: 15.0,
//     //                                     fontWeight: FontWeight.bold,
//     //                                   ),
//     //                                 ),
//     //
//     //
//     //
//     //                                 DropdownButton(
//     //                                   isExpanded: true,
//     //                                   value: dropDownValue,
//     //                                   icon: Icon(stocks[0].ic1),
//     //                                   items: items.map((String items) {
//     //                                     return DropdownMenuItem(
//     //                                       value: items,
//     //                                       child:
//     //                                           //Text(stocks[0].item.toString(),),
//     //                                           Text(items),
//     //                                       alignment: Alignment.center,
//     //                                     );
//     //                                   }).toList(),
//     //                                   onChanged: (String? newValue) {
//     //                                     setState(() {
//     //                                       dropDownValue = newValue!;
//     //                                     });
//     //                                   },
//     //                                 ),
//     //                                 DropdownButton(
//     //                                   isExpanded: true,
//     //                                   value: dropDownValue,
//     //                                   icon:
//     //                                       const Icon(Icons.keyboard_arrow_down),
//     //                                   items: items.map((String items) {
//     //                                     return DropdownMenuItem(
//     //                                       value: items,
//     //                                       child: Text(items),
//     //                                       alignment: Alignment.center,
//     //                                     );
//     //                                   }).toList(),
//     //                                   onChanged: (String? newValue) {
//     //                                     setState(() {
//     //                                       dropDownValue = newValue!;
//     //                                     });
//     //                                   },
//     //                                 ),
//     //                                 const Text(
//     //                                   'PRODUCT : ',
//     //                                   style: TextStyle(
//     //                                     fontSize: 15.0,
//     //                                     fontWeight: FontWeight.bold,
//     //                                   ),
//     //                                 ),
//     //                                 DropdownButton(
//     //                                   isExpanded: true,
//     //                                   value: prod,
//     //                                   icon:
//     //                                       const Icon(Icons.keyboard_arrow_down),
//     //                                   items: products.map((String products) {
//     //                                     return DropdownMenuItem(
//     //                                       value: products,
//     //                                       child: Text(products),
//     //                                       alignment: Alignment.center,
//     //                                     );
//     //                                   }).toList(),
//     //                                   onChanged: (String? newValue) {
//     //                                     setState(() {
//     //                                       prod = newValue!;
//     //                                     });
//     //                                   },
//     //                                 ),
//     //                                 const Text(
//     //                                   'SIZE :',
//     //                                   style: TextStyle(
//     //                                     fontSize: 15.0,
//     //                                     fontWeight: FontWeight.bold,
//     //                                   ),
//     //                                 ),
//     //                                 DropdownButton(
//     //                                   isExpanded: true,
//     //                                   value: siz,
//     //                                   icon:
//     //                                       const Icon(Icons.keyboard_arrow_down),
//     //                                   items: sizes.map((String sizes) {
//     //                                     return DropdownMenuItem(
//     //                                       value: sizes,
//     //                                       child: Text(sizes),
//     //                                       alignment: Alignment.center,
//     //                                     );
//     //                                   }).toList(),
//     //                                   onChanged: (String? newValue) {
//     //                                     setState(() {
//     //                                       siz = newValue!;
//     //                                     });
//     //                                   },
//     //                                 ),
//     //                                 const Text(
//     //                                   'GENDER : ',
//     //                                   style: TextStyle(
//     //                                     fontSize: 15.0,
//     //                                     fontWeight: FontWeight.bold,
//     //                                   ),
//     //                                 ),
//     //
//     //                                 Row(
//     //                                   mainAxisAlignment:
//     //                                       MainAxisAlignment.center,
//     //                                   children: [
//     //                                     Radio(
//     //                                       value: boys,
//     //                                       groupValue: gender,
//     //                                       onChanged: (value) => setState(() {
//     //                                         gender = boys;
//     //                                       }),
//     //                                     ),
//     //                                     const Text(
//     //                                       'BOYS ',
//     //                                     ),
//     //                                     Radio(
//     //                                       value: girls,
//     //                                       groupValue: gender,
//     //                                       onChanged: (value) => setState(() {
//     //                                         gender = girls;
//     //                                       }),
//     //                                     ),
//     //                                     const Text(
//     //                                       'GIRLS',
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                                 const Text(
//     //                                   'QUANTITY: ',
//     //                                   style: TextStyle(
//     //                                     fontSize: 15.0,
//     //                                     fontWeight: FontWeight.bold,
//     //                                   ),
//     //                                 ),
//     //                                 //Counter
//     //                                 Row(
//     //                                   children: [
//     //                                     Expanded(
//     //                                       flex: 3,
//     //                                       child: ElevatedButton(
//     //                                         style: ButtonStyle(
//     //                                           backgroundColor:
//     //                                               MaterialStateProperty.all(
//     //                                             const Color.fromRGBO(
//     //                                                 157, 55, 67, 1),
//     //                                           ),
//     //                                         ),
//     //                                         onPressed: () => setState(() {
//     //                                           _counter++;
//     //                                         }),
//     //                                         child: const Icon(Icons.add),
//     //                                       ),
//     //                                     ),
//     //                                     Expanded(
//     //                                       flex: 4,
//     //                                       child: TextFormField(
//     //                                         decoration: InputDecoration(
//     //                                           hintText: '$_counter',
//     //                                         ),
//     //                                         style: const TextStyle(
//     //                                           fontSize: 25.0,
//     //                                         ),
//     //                                       ),
//     //                                     ),
//     //                                     Expanded(
//     //                                       flex: 3,
//     //                                       child: ElevatedButton(
//     //                                         style: ButtonStyle(
//     //                                           backgroundColor:
//     //                                               MaterialStateProperty.all(
//     //                                                   const Color.fromRGBO(
//     //                                                       157, 55, 67, 1)),
//     //                                         ),
//     //                                         onPressed: () => setState(() {
//     //                                           _counter == 0
//     //                                               ? _counter = 0
//     //                                               : _counter--;
//     //                                         }),
//     //                                         child: const Icon(Icons.remove),
//     //                                       ),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ],
//     //                             ),
//     //                           ),
//     //                           MaterialButton(
//     //                             onPressed: () {
//     //                               // Navigator.push(
//     //                               //     context,
//     //                               //     MaterialPageRoute(
//     //                               //         builder: (context) => add()));
//     //                             },
//     //                             child: const Text(
//     //                               'ADD',
//     //                               style: TextStyle(
//     //                                 color: Colors.white,
//     //                               ),
//     //                             ),
//     //                             color: const Color.fromRGBO(157, 55, 67, 1),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //
//     //                 //DEDUCT
//     //                 MaterialButton(
//     //                   child: const Text(
//     //                     'DEDUCT STOCK',
//     //                     style: TextStyle(
//     //                       color: Colors.white,
//     //                       fontWeight: FontWeight.bold,
//     //                     ),
//     //                   ),
//     //                   color: Colors.cyan.shade800,
//     //                   height: 60.0,
//     //                   minWidth: 150.0,
//     //                   onPressed: () => showDialog(
//     //                     context: context,
//     //                     builder: (context) => StatefulBuilder(
//     //                       builder: (context, setState) => SimpleDialog(
//     //                         children: [
//     //                           Column(
//     //                             children: [
//     //                               const Text(
//     //                                 'SCHOOL : ',
//     //                                 style: TextStyle(
//     //                                   fontSize: 18.0,
//     //                                   fontWeight: FontWeight.bold,
//     //                                 ),
//     //                               ),
//     //                               DropdownButton(
//     //                                 isExpanded: true,
//     //                                 value: dropDownValue,
//     //                                 icon: const Icon(Icons.keyboard_arrow_down),
//     //                                 items: items.map((String items) {
//     //                                   return DropdownMenuItem(
//     //                                     value: items,
//     //                                     child: Text(items),
//     //                                     alignment: Alignment.center,
//     //                                   );
//     //                                 }).toList(),
//     //                                 onChanged: (String? newValue) {
//     //                                   setState(() {
//     //                                     dropDownValue = newValue!;
//     //                                   });
//     //                                 },
//     //                               ),
//     //                               const Text(
//     //                                 'PRODUCT : ',
//     //                                 style: TextStyle(
//     //                                   fontSize: 18.0,
//     //                                   fontWeight: FontWeight.bold,
//     //                                 ),
//     //                               ),
//     //                               DropdownButton(
//     //                                 isExpanded: true,
//     //                                 value: prod,
//     //                                 icon: const Icon(Icons.keyboard_arrow_down),
//     //                                 items: products.map((String products) {
//     //                                   return DropdownMenuItem(
//     //                                     value: products,
//     //                                     child: Text(products),
//     //                                     alignment: Alignment.center,
//     //                                   );
//     //                                 }).toList(),
//     //                                 onChanged: (String? newValue) {
//     //                                   setState(() {
//     //                                     prod = newValue!;
//     //                                   });
//     //                                 },
//     //                               ),
//     //                               const Text(
//     //                                 'SIZE : ',
//     //                                 style: TextStyle(
//     //                                   fontSize: 18.0,
//     //                                   fontWeight: FontWeight.bold,
//     //                                 ),
//     //                               ),
//     //                               DropdownButton(
//     //                                 isExpanded: true,
//     //                                 value: siz,
//     //                                 icon: const Icon(Icons.keyboard_arrow_down),
//     //                                 items: sizes.map((String sizes) {
//     //                                   return DropdownMenuItem(
//     //                                     value: sizes,
//     //                                     child: Text(sizes),
//     //                                     alignment: Alignment.center,
//     //                                   );
//     //                                 }).toList(),
//     //                                 onChanged: (String? newValue) {
//     //                                   setState(() {
//     //                                     siz = newValue!;
//     //                                   });
//     //                                 },
//     //                               ),
//     //                               const Text(
//     //                                 'GENDER : ',
//     //                                 style: TextStyle(
//     //                                   fontSize: 18.0,
//     //                                   fontWeight: FontWeight.bold,
//     //                                 ),
//     //                               ),
//     //                               Row(
//     //                                 children: [
//     //                                   Radio(
//     //                                     value: boys,
//     //                                     groupValue: gender,
//     //                                     onChanged: (value) => setState(() {
//     //                                       gender = boys;
//     //                                     }),
//     //                                   ),
//     //                                   const Text(
//     //                                     'BOYS: ',
//     //                                   ),
//     //                                   Radio(
//     //                                     value: girls,
//     //                                     groupValue: gender,
//     //                                     onChanged: (value) => setState(() {
//     //                                       gender = girls;
//     //                                     }),
//     //                                   ),
//     //                                   const Text(
//     //                                     'GIRLS',
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                               //Counter
//     //                               Row(
//     //                                 children: [
//     //                                   Expanded(
//     //                                     flex: 3,
//     //                                     child: ElevatedButton(
//     //                                       style: ButtonStyle(
//     //                                         backgroundColor:
//     //                                             MaterialStateProperty.all(
//     //                                           const Color.fromRGBO(
//     //                                               157, 55, 67, 1),
//     //                                         ),
//     //                                       ),
//     //                                       onPressed: () => setState(() {
//     //                                         _counter++;
//     //                                       }),
//     //                                       child: const Icon(Icons.add),
//     //                                     ),
//     //                                   ),
//     //                                   Expanded(
//     //                                     flex: 4,
//     //                                     child: TextFormField(
//     //                                       decoration: InputDecoration(
//     //                                         hintText: '$_counter',
//     //                                       ),
//     //                                       style: Theme.of(context)
//     //                                           .textTheme
//     //                                           .headline4,
//     //                                     ),
//     //                                   ),
//     //                                   Expanded(
//     //                                     flex: 3,
//     //                                     child: ElevatedButton(
//     //                                       style: ButtonStyle(
//     //                                         backgroundColor:
//     //                                             MaterialStateProperty.all(
//     //                                                 const Color.fromRGBO(
//     //                                                     157, 55, 67, 1)),
//     //                                       ),
//     //                                       onPressed: () => setState(() {
//     //                                         _counter == 0
//     //                                             ? _counter = 0
//     //                                             : _counter--;
//     //                                       }),
//     //                                       child: const Icon(Icons.remove),
//     //                                     ),
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                             ],
//     //                           ),
//     //                           MaterialButton(
//     //                             onPressed: () {
//     //                               // Navigator.push(
//     //                               //     context,
//     //                               //     MaterialPageRoute(
//     //                               //         builder: (context) => add()));
//     //                             },
//     //                             child: const Text(
//     //                               'DEDUCT',
//     //                               style: TextStyle(
//     //                                 color: Colors.white,
//     //                               ),
//     //                             ),
//     //                             color: const Color.fromRGBO(157, 55, 67, 1),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ],
//     //           // SizedBox(
//     //           //   height: 30.0,
//     //           // ),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }
//
// class Demo {
//   final StreamController controller = StreamController();
//
//   get demoStream => controller.stream;
//
//   get demoSink => controller.sink;
//
//   // StreamController<bool> controller1 = StreamController();
//   //
//   // Stream<bool> get demoStream1 => controller.stream;
//   //
//   // Sink<bool> get demoSink1 => controller.sink;
//
//   setdata(value) {
//     demoSink.add(value);
//   }
// }
