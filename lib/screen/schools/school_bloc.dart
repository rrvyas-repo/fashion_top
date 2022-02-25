import 'dart:async';
import 'package:fashion_top/models/school_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class SchoolBloc {
  static StreamController<List<SchoolModel>> schoolDataController =
      BehaviorSubject<List<SchoolModel>>();
  static StreamController<int> totalSchoolController = BehaviorSubject<int>();

  static Stream<List<SchoolModel>> get schoolBlocStream =>
      schoolDataController.stream;

  static Stream<int> get totalSchoolBlocStream => totalSchoolController.stream;

  static Sink<List<SchoolModel>> get schoolBlocSink =>
      schoolDataController.sink;

  static Sink<int> get totalSchoolBlocSink => totalSchoolController.sink;

  static setData() async {
    schoolData.clear();
    await FirebaseDatabase.instance.ref('School').once().then((value) {
      Map temp = value.snapshot.value as Map;
      temp.forEach((key, value) {
        //print(key+":"+value);
        schoolData.add(
          SchoolModel(
            schoolName: value['schoolName'],
            schoolContactPerson: value['schoolContactPerson'],
            schoolContact: value['schoolContact'],
            schoolAddress: value['schoolAddress'],
            schoolPinCode: value['schoolPinCode'],
            key: value['key'],
          ),
        );
      });
      schoolBlocSink.add(schoolData);
      totalSchoolBlocSink.add(schoolData.length);
    });
  }

  dispose() {
    schoolDataController.close();
  }
}
