import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/screen/report/report_widget.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:flutter/material.dart';

double screenHeight = 0;
double screenWidth = 0;

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  var formKey = GlobalKey<FormState>();
  DateTime inDate = DateTime.now();
  DateTime outDate = DateTime.now();

  TextEditingController dateInputCheckIn = TextEditingController();
  TextEditingController dateInputCheckOut = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: [
              txtFrmFieldDate(
                boolValue: true,
                onTapValue: checkInOutDate(
                    firstDate: DateTime(2000),
                    contextValue: context,
                    initialDateValue: inDate,
                    dateInputCheckInOut: dateInputCheckIn,
                    setState: setState),
                controllerValue: dateInputCheckIn,
                hintTxt: inDateHint,
                labelTxt: inDateLabel,
                suffixIcn: calenderIcn,
              ),
              txtFrmFieldDate(
                boolValue: true,
                onTapValue: checkInOutDate(
                    firstDate: DateTime.now(),
                    contextValue: context,
                    initialDateValue: inDate,
                    dateInputCheckInOut: dateInputCheckOut,
                    setState: setState),
                controllerValue: dateInputCheckOut,
                hintTxt: outDateHint,
                labelTxt: outDateLabel,
                suffixIcn: calenderIcn,
              ),
              mtrBtn(
                  txtName: submitBtnTxt,
                  backClr: appFromClr,
                  clr: white,
                  width: screenWidth,
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
