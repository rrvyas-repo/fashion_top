// import 'dart:async';
// import 'package:fashion_top/models/product_model.dart';
// import 'package:fashion_top/models/size_model.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:rxdart/rxdart.dart';
//
// class SizeBloc {
//   static StreamController<List<SizeModel>> sizeDataController =
//          BehaviorSubject<List<SizeModel>>();
//   static StreamController<int> totalSizeController = BehaviorSubject<int>();
//
//   static Stream<List<SizeModel>> get sizeBlocStream =>
//       sizeDataController.stream;
//
//   static Stream<int> get totalSizeBlocStream =>
//       totalSizeController.stream;
//
//   static StreamSink<List<SizeModel>> get sizeBlocSink =>
//       sizeDataController.sink;
//
//   static Sink<int> get totalSizeBlocSink => totalSizeController.sink;
//
//   static setData() async {
//     sizeData.clear();
//     await FirebaseDatabase.instance.ref('Size').once().then((value) {
//       Map temp = value.snapshot.value as Map;
//       temp.forEach((key, value) {
//         sizeData.add(
//           SizeModel(
//             product: value['product'],
//             sizes: [],
//             key: value['key'],
//             // productName: value['productName'],
//             // key: value['key'],
//           ),
//         );
//       });
//       print('-----$sizeData');
//       sizeBlocSink.add(sizeData);
//       totalSizeBlocSink.add(sizeData.length);
//     });
//   }
//
//   dispose() {
//     sizeDataController.close();
//   }
// }
