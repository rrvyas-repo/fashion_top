import 'package:fashion_top/screen/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      debugShowCheckedModeBanner: false,
      home:const Login(),
    ),
  );
}
