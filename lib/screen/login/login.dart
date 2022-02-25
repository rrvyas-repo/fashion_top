import 'package:fashion_top/common/texts.dart';
import 'package:fashion_top/screen/Home_page/home_page.dart';
import 'package:fashion_top/utils/colors.dart';
import 'package:fashion_top/utils/icons.dart';
import 'package:fashion_top/utils/string.dart';
import 'package:flutter/material.dart';
import '../forgot_pwd/forget_password.dart';
import 'login_page_widget.dart';

double screenHeight = 0;
double screenWidth = 0;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visible = true;
  var key1 = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  fashionTop(),
                  Padding(
                    padding: const EdgeInsets.only(top: 280.0),
                    child: Container(
                      height: screenHeight / 1.8,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                        ),
                      ),
                      child: Form(
                        key: key1,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              txt(
                                  textValue: txtLogin,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                              txtFrmField(
                                controllerValue: emailController,
                                onChanged: (val){
                                  if(val[val.length-1]=='@') {
                                      setState(() {
                                        emailController.text += 'gmail.com';
                                      },);
                                    }
                                  },
                                  validator: (String? p0) => validateEmail(p0!),
                                  labelTxt: txtEmailID,
                                  hintTxt: emailTxt,
                                  keyboardInputType: TextInputType.emailAddress,
                                  suffixIcn: Icon(email, color: appFromClr),
                                  obscureTxt: false),
                              sizedBox(8.0),
                              txtFrmField(
                                  validator: (String? p0) => validatePass(p0!),
                                  labelTxt: txtLoginPwd,
                                  hintTxt: passwordTxt,
                                  keyboardInputType:
                                      TextInputType.visiblePassword,
                                  suffixIcn: IconButton(
                                    icon: Icon(
                                      visible ? passUnVisible : passVisible,
                                      color: appFromClr,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          visible = !visible;
                                        },
                                      );
                                    },
                                  ),
                                  obscureTxt: visible),
                              // sizedBox(24.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPwd()));
                                },
                                child: Text(
                                  forgotPassTxtBtn,
                                  style: const TextStyle(color: appFromClr),
                                ),
                              ),
                              mtrBtn(
                                txtName: txtLogin,
                                backClr: appFromClr,
                                clr: white,
                                width: screenWidth,
                                onTap: () {
                                  if (key1.currentState!.validate()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
