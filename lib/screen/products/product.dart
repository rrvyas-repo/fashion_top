import 'package:fashion_top/models/product_model.dart';
import 'package:fashion_top/screen/products/product_bloc.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:fashion_top/widgets/product_simple_dialogs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // TextEditingController productName = TextEditingController();
  // String? txtUpdateProductName;

  FirebaseDatabase db = FirebaseDatabase.instance;

  @override
  void initState() {
    ProductBloc.setData();
    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   productDetails();
  // }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          appBarProduct,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(157, 55, 67, 1),
                ),
                filled: true,
                hintText: searchProduct,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: StreamBuilder<List<ProductModel>>(
              stream: ProductBloc.productBlocStream,
              builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                // print('*******************');
                return snapshot.hasData && productData.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductBloc.totalProductBlocSink == 0
                            ? const Text('data')
                            : ListView.builder(
                                itemCount: productData.length,
                                itemBuilder: (context, index) {
                                  String item = productData[index].toString();
                                  return Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.startToEnd) {}
                                    },
                                    confirmDismiss:
                                        (DismissDirection direction) async {
                                      Future.value(direction ==
                                          DismissDirection.startToEnd);
                                      return await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(deleteSchool),
                                              const Divider(
                                                color: Color.fromRGBO(
                                                    215, 215, 215, 1),
                                              ),
                                              Text(productData[index]
                                                  .productName),
                                            ],
                                          ),
                                          content: const Text(
                                            deleteSchoolDetail,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: appFromClr),
                                              onPressed: () {
                                                db
                                                    .ref('Product')
                                                    .child(
                                                        productData[index].key)
                                                    .remove();

                                                Navigator.pop(context);
                                                productData.removeAt(index);
                                                setState(() {});
                                                ProductBloc.setData();
                                              },
                                              child: const Text(
                                                btnDelete,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: appFromClr),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(btnCancel),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: GestureDetector(
                                      child: Card(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        elevation: 5.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            color: Colors.grey.shade200,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                productData[index].productName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                appFromClr),
                                                    onPressed: () {
                                                      productSimpleDialogs(
                                                          context,
                                                          'edit',
                                                          productData[index],
                                                          updateSchool, () {
                                                        ProductBloc.setData();
                                                      });
                                                    },
                                                    child: const Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          title: Text(
                                              productData[index].productName),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Divider(
                                                color: Color.fromRGBO(
                                                    215, 215, 215, 1),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: appFromClr),
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); //press delete
                                                ProductBloc.setData();
                                              },
                                              child: const Text(
                                                btnOk,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    : const Center(
                        child: Text(
                          listOfProduct,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              color: appFromClr,
              height: 56.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconAdd,
                    color: btnIconWhite,
                  ),
                  const Text(btnAddProduct,
                      style: TextStyle(
                          color: btnTextWhite, fontWeight: FontWeight.bold)),
                ],
              ),
              onPressed: () {
                productSimpleDialogs(
                    context,
                    'add',
                    ProductModel(
                      productName: '',
                      key: '',
                    ),
                    btnAddProduct, () {
                  ProductBloc.setData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
