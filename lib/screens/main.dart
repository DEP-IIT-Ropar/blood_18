import 'package:app/screens/authenticate/signup/signupmedi.dart';
import 'package:app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/home/homedonor/home.dart';
import 'package:app/screens/login/login.dart';
import 'package:app/screens/authenticate/signup/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
      /*initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/signupmedi': (context) => SignupPageMedi(),
      },*/
    );
  }
}
