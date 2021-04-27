import 'package:app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/screens/service/auth.dart';

class HomePageMedi extends StatefulWidget {
  HomePageMedi({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _HomePageMediState createState() => _HomePageMediState();
}

class _HomePageMediState extends State<HomePageMedi> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  final _emailController = TextEditingController();
  String bloodgrp;
  String phone;
  String name;
  DateTime selectedDate = DateTime.now();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> bloodgrps = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.red[400],
                      size: 50.0,
                    ),
                  ),
                  accountName: Text('User Name'),
                  accountEmail: Text('examlpe@gmail.com'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[400],
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Profile Settings"),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[400],
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Settings"),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[400],
                    child: Icon(
                      Icons.help_outline,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("About us"),
                  onTap: () {},
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[400],
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Logout"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage())).then((result) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Verify Donor"),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () {},
        child: Icon(Icons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red[400],
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.red[400],
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
          ),
        ],
      ),
      body: ListView(
        key: _formKey,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 62),
            child: Column(
              key: _formKey,
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
                  child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter Donor Name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
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
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Donor Blood Group',
                      ),
                      items: bloodgrps.map((bloodgrp) {
                        return DropdownMenuItem(
                          value: bloodgrp,
                          child: Text('$bloodgrp'),
                        );
                      }).toList(),
                      validator: (val) =>
                          val.isEmpty ? 'Select donor blood group' : null,
                      onChanged: (val) {
                        setState(() => bloodgrp = val);
                      }),
                ),
                SizedBox(
                  height: 5,
                ),
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                    controller: _emailController,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
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
                    decoration: InputDecoration(
                      hintText: "${selectedDate.toLocal()}".split(' ')[0],
                      suffixIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageMedi()))
                        .then((result) {
                      Navigator.of(context).pop();
                    });
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
                        'Verify'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
