import 'package:fashion_top/models/school_model.dart';
import 'package:fashion_top/screen/schools/school_widgets.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final TextEditingController schoolName = TextEditingController();
final TextEditingController schoolContactPerson = TextEditingController();
final TextEditingController schoolContactNumber = TextEditingController();
final TextEditingController schoolAddress = TextEditingController();
final TextEditingController schoolPinCode = TextEditingController();

FirebaseDatabase db = FirebaseDatabase.instance;

schoolSimpleDialogs(
  context,
  String addEdit,
  SchoolModel data,
  String btn,
  Function() onRefresh,
) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            addSchoolDetail,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Color.fromRGBO(215, 215, 215, 1),
          ),
        ],
      ),
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Divider(
              //   color: Color.fromRGBO(215, 215, 215, 1),
              // ),
              textFormFields(
                label: lblSchoolName,
                keyBoardType: TextInputType.text,
                txtController: schoolName..text = data.schoolName,
                hintTexts: addSchoolName,
                borderColor: borderColorBlack,
                borderRadius: 10.0,
              ),
              textFormFields(
                label: lblContactPerson,
                keyBoardType: TextInputType.text,
                txtController: schoolContactPerson
                  ..text = data.schoolContactPerson,
                hintTexts: addContactPerson,
                borderColor: borderColorBlack,
                borderRadius: 10.0,
              ),
              textFormFields(
                label: lblContactNumber,
                keyBoardType: TextInputType.phone,
                txtController: schoolContactNumber..text = data.schoolContact,
                hintTexts: addContactNumber,
                borderColor: borderColorBlack,
                borderRadius: 10.0,
              ),
              textFormFields(
                label: lblAddress,
                keyBoardType: TextInputType.multiline,
                txtController: schoolAddress..text = data.schoolAddress,
                hintTexts: addAddress,
                maxLine: 3,
                borderColor: borderColorBlack,
                borderRadius: 10.0,
              ),
              textFormFields(
                label: lblPinCode,
                keyBoardType: TextInputType.number,
                txtController: schoolPinCode..text = data.schoolPinCode,
                hintTexts: addPinCode,
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
                      db.ref('School').child(data.key).update({
                        'schoolName': schoolName.text,
                        'schoolContactPerson': schoolContactPerson.text,
                        'schoolContact': schoolContactNumber.text,
                        'schoolAddress': schoolAddress.text,
                        'schoolPinCode': schoolPinCode.text,
                        'key': data.key,
                      });
                    } else {
                      String? key = db.ref().push().key;
                      db.ref('School').child(key!).set({
                        'schoolName': schoolName.text,
                        'schoolContactPerson': schoolContactPerson.text,
                        'schoolContact': schoolContactNumber.text,
                        'schoolAddress': schoolAddress.text,
                        'schoolPinCode': schoolPinCode.text,
                        'key': key,
                      });
                    }
                    schoolName.clear();
                    schoolContactPerson.clear();
                    schoolContactNumber.clear();
                    schoolAddress.clear();
                    schoolPinCode.clear();
                    onRefresh();
                    Navigator.pop(context);
                  },
                  child: Text(btn,
                      style: TextStyle(
                          color: btnTextWhite, fontWeight: FontWeight.bold)
                      // style: TextStyle(color: btnTextWhite),
                      ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
