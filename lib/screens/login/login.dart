import 'package:app/screens/authenticate/signup/signup.dart';
import 'package:app/screens/authenticate/signup/signupmedi.dart';
import 'package:app/screens/home/homedonor/home.dart';
import 'package:app/screens/home/homemedi/homemedi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/screens/service/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  String radioButtonItem = 'Medical Staff';
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';

  // Group Value for Radio Button.
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.red[400], Colors.red[400]],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Colors.red[400],
                        ),
                        hintText: 'Username',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.red[400],
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: id,
                        activeColor: Colors.red[400],
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'Medical Staff';
                            id = 1;
                          });
                        },
                      ),
                      Text(
                        'Medical Staff',
                        style: new TextStyle(fontSize: 17.0),
                      ),
                      Radio(
                        value: 2,
                        groupValue: id,
                        activeColor: Colors.red[400],
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'User';
                            id = 2;
                          });
                        },
                      ),
                      Text(
                        'User',
                        style: new TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      if (radioButtonItem == 'Medical Staff') {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageMedi()))
                            .then((result) {
                          Navigator.of(context).pop();
                        });
                      } else {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()))
                            .then((result) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red[400],
                              Colors.red[400],
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Login'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account ?"),
                  Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                ],
              ),
              onTap: () {
                showAlertDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the list options
  Widget optionOne = SimpleDialogOption(
    child: const Text('Medical Staff'),
    onPressed: () {
      Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignupPageMedi()))
          .then((result) {
        Navigator.of(context).pop();
      });
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('User'),
    onPressed: () {
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupPage()))
          .then((result) {
        Navigator.of(context).pop();
      });
    },
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Who are you?'),
    children: <Widget>[
      optionOne,
      optionTwo,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
