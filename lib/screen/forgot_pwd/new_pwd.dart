import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/screen/Home_page/home_page.dart';
import 'package:fashion_top/screen/login/login_page_widget.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:flutter/material.dart';

double screenHeight = 0;
double screenWidth = 0;

class NewPwd extends StatefulWidget {
  const NewPwd({Key? key}) : super(key: key);

  @override
  _NewPwdState createState() => _NewPwdState();
}

class _NewPwdState extends State<NewPwd> {
  bool visible = true;
  bool signUpVisible = true;
  bool visibleCnfPass = true;
  var key1 = GlobalKey<FormState>();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: screenHeight * 0.65,
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
                      textValue: newPassTxt,
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  Column(
                    children: [
                      txtFrmField(
                          validator: (String? p0)=> validatePass(p0!),
                          controllerValue: _pass,
                          labelTxt: txtLoginPwd,
                          hintTxt: passwordTxt,
                          clr: Colors.white,
                          keyboardInputType: TextInputType.visiblePassword,
                          suffixIcn: IconButton(
                            icon: Icon(
                                signUpVisible ? passUnVisible : passVisible),
                            onPressed: () {
                              setState(() {
                                signUpVisible = !signUpVisible;
                              });
                            },
                          ),
                          obscureTxt: signUpVisible),
                      sizedBox(6.0),
                      txtFrmField(
                        obscureTxt: visibleCnfPass,
                        controllerValue: _confirmPass,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter confirm password';
                          }
                          if (val != _pass.text) {
                            return 'Both password must be same';
                          } //Not Match
                          return ' ';
                        },
                        labelTxt: txtLoginPwd,
                        hintTxt: 'Confirm Password',
                        clr: Colors.white,
                        keyboardInputType: TextInputType.visiblePassword,
                        suffixIcn: IconButton(
                          icon: Icon(
                              visibleCnfPass ? passUnVisible : passVisible),
                          onPressed: () {
                            key1.currentState!.validate();
                            setState(() {
                              visibleCnfPass = !visibleCnfPass;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  // MaterialButton(
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  //   height: 50,
                  //   minWidth: screenWidth,
                  //   onPressed: () {
                  //     key1.currentState!.validate();
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const HomePage(),
                  //       ),
                  //     );
                  //   },
                  //   child: const Text(
                  //     'Continue',
                  //     style: TextStyle(color: conRedLogin),
                  //   ),
                  //   color: Colors.white,
                  // ),
                  mtrBtn(
                      width: screenWidth,
                      clr: appFromClr,
                      backClr: white,
                      txtName: continueBtn,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
