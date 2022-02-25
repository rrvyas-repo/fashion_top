import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/models/school_model.dart';
import 'package:fashion_top/screen/schools/school_bloc.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:fashion_top/widgets/school_simple_dialogs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SchoolList extends StatefulWidget {
  const SchoolList({Key? key}) : super(key: key);

  @override
  State<SchoolList> createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  FirebaseDatabase db = FirebaseDatabase.instance;

  @override
  void initState() {
    SchoolBloc.setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            //super.initState();
            // initState();
          },
          icon: Icon(
            icArrowBack,
            color: black,
          ),
        ),
        title: txt(
          // fontSize: 0.0,
          textValue: appBarSchool,
          color: black,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextFormField(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(157, 55, 67, 1),
                ),
                filled: true,
                hintText: searchSchool,
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
            child: StreamBuilder<List<SchoolModel>>(
              stream: SchoolBloc.schoolBlocStream,
              builder: (context, AsyncSnapshot<List<SchoolModel>> snapshot) {
                // print('+-+-+-+-+-+');
                return snapshot.hasData && schoolData.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SchoolBloc.totalSchoolBlocSink == 0
                            ? const Text('data')
                            : ListView.builder(
                                itemCount: schoolData.length,
                                itemBuilder: (context, index) {
                                  String item = schoolData[index].toString();
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
                                              Text(
                                                  schoolData[index].schoolName),
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
                                                    .ref('School')
                                                    .child(
                                                        schoolData[index].key)
                                                    .remove();

                                                Navigator.pop(context);
                                                schoolData.removeAt(index);
                                                setState(() {});
                                                SchoolBloc.setData();
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
                                      // SimpleDialog(
                                      //   children: [
                                      //     MaterialButton(onPressed: () => setState(() {
                                      //       schoolData.removeAt(index);
                                      //     }),child: const Text('Done'),)
                                      //   ],
                                      // ),);
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
                                          // height: 100.0,

                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                schoolData[index].schoolName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                schoolData[index]
                                                    .schoolContactPerson,
                                              ),
                                              Text(
                                                schoolData[index].schoolContact,
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
                                                    // color:appFromClr,
                                                    onPressed: () {
                                                      schoolSimpleDialogs(
                                                          context,
                                                          'edit',
                                                          schoolData[index],
                                                          updateSchool, () {
                                                        SchoolBloc.setData();
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
                                              schoolData[index].schoolName),
                                          content: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Divider(
                                                color: Color.fromRGBO(
                                                    215, 215, 215, 1),
                                              ),
                                              // Text(
                                              //   schoolData[index].schoolName,
                                              //   style: TextStyle(
                                              //       fontWeight: FontWeight.bold),
                                              // ),
                                              Text(
                                                schoolData[index]
                                                    .schoolContactPerson,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                schoolData[index]
                                                    .schoolContact
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                schoolData[index].schoolAddress,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                schoolData[index]
                                                    .schoolPinCode
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                SchoolBloc.setData();
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
                                }

                                ),
                      )
                    : const Center(
                        child: Text(
                          listOfSchool,
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
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconAdd,
                    color: btnIconWhite,
                  ),
                  const Text(
                    btnAddSchool,
                    style: TextStyle(
                      color: btnTextWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // minWidth: 43.0,
              onPressed: () {
                schoolSimpleDialogs(
                    context,
                    'add',
                    SchoolModel(
                      schoolName: '',
                      schoolContactPerson: '',
                      schoolContact: '',
                      schoolAddress: '',
                      schoolPinCode: '',
                      key: '',
                    ),
                    btnAddSchool, () {
                  SchoolBloc.setData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
