import 'package:app/screens/home/homemedi/donated.dart';
import 'package:app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/screens/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/screens/home/homemedi/verifydonor.dart';

class MediDash extends StatefulWidget {
  MediDash({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _MediDashState createState() => _MediDashState();
}

class _MediDashState extends State<MediDash> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

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
                  accountName: Text("Medi"),
                  accountEmail: Text(widget.uid),
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
        title: Text("Home"),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem("Verify", Icons.person),
            makeDashboardItem("Donated?", Icons.water_damage)
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
            decoration:
                BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
            child: new InkWell(
                onTap: () {
                  if (title == "Verify") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerifyDonor(
                                uid: widget.uid,
                              )),
                    );
                  }
                  if (title == "Donated?") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Donated(
                                uid: widget.uid,
                              )),
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Center(
                        child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                    SizedBox(height: 20.0),
                    new Center(
                      child: new Text(title,
                          style: new TextStyle(
                              fontSize: 18.0, color: Colors.black)),
                    )
                  ],
                ))));
  }
}
