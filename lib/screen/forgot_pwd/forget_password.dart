import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/screen/login/login_page_widget.dart';
import 'package:fashion_top/screen/forgot_pwd/new_pwd.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:flutter/material.dart';

double screenHeight = 0;
double screenWidth = 0;

class ForgotPwd extends StatefulWidget {
  const ForgotPwd({Key? key}) : super(key: key);

  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  var key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: screenHeight * 0.60,
          width: screenWidth * 0.80,
          color: appFromClr,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: key1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  txt(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textValue: forgotPassTxt),
                  txtFrmField(
                      validator: (String? p0) => validateEmail(p0!),
                      hintTxt: txtEmailAdd,
                      labelTxt: txtEmailID,
                      clr: Colors.white,
                      keyboardInputType: TextInputType.emailAddress,
                      suffixIcn: Icon(email, color: appFromClr),
                      obscureTxt: false),
                  mtrBtn(
                      txtName: continueBtn,
                      width: screenWidth,
                      clr: appFromClr,
                      backClr: Colors.white,
                      onTap: () {
                        if (key1.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewPwd(),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
