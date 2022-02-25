import 'dart:async';
import 'package:fashion_top/models/product_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  static StreamController<List<ProductModel>> productDataController =
      BehaviorSubject<List<ProductModel>>();
  static StreamController<int> totalProductController = BehaviorSubject<int>();

  static Stream<List<ProductModel>> get productBlocStream =>
      productDataController.stream;

  static Stream<int> get totalProductBlocStream =>
      totalProductController.stream;

  static Sink<List<ProductModel>> get productBlocSink =>
      productDataController.sink;

  static Sink<int> get totalProductBlocSink => totalProductController.sink;

  static setData() async {
    productData.clear();
    await FirebaseDatabase.instance.ref('Product').once().then((value) {
      Map temp = value.snapshot.value as Map;
      temp.forEach((key, value) {
        productData.add(
          ProductModel(
            productName: value['productName'],
            key: value['key'],
          ),
        );
      });
      // print('-----$productData');
      productBlocSink.add(productData);
      totalProductBlocSink.add(productData.length);
    });
  }

  dispose() {
    productDataController.close();
  }
}
