import 'package:app/screens/home/homedonor/requestdonor.dart';
import 'package:app/screens/home/homedonor/updatelocation.dart';
import 'package:app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
//update the constructor to include the uid
  final String title;
  final String uid; //include this
  HomePage({Key key, this.title, this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DocumentSnapshot variable;
  bool isSwitched = false ;
  void database() async {
    variable = await Firestore.instance
        .collection('userInfo')
        .document(widget.uid)
        .get();
    isSwitched = variable.data['available'];
    if (variable.data['location'] == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UpdateLocation(
                    uid: widget.uid,
                  ))).then((result) {
        Navigator.of(context).pop();
      });
    }
  }


  var textValue = 'Switch is OFF';
  bool _hasBeenPressed = false;
  bool _hasBeenPressed1 = false;


  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      setState(() async {
        final availability = await Firestore.instance
            .collection('userInfo')
            .document(widget.uid)
            .updateData(
          {'available': true},
        );
      });
      print('Switch Button is ON');
    } else {
      setState(() /*async*/ {
        isSwitched = false;
      });
      setState(() async {
        final availability = await Firestore.instance
            .collection('userInfo')
            .document(widget.uid)
            .updateData(
          {'available': false},
        );
      });
      print('Switch Button is OFF');
    }
  }

  @override
  void initState() {
    database();
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
                  accountName: Text("Mithilesh"
                      /*variable.data['name'],
                    style: TextStyle(
                      color: Colors.white,*/
                      ),
                  accountEmail: Text("mkkrazy456@gmail.com"
                      /*variable.data['name'],
                    style: TextStyle(
                      color: Colors.white,*/
                      ),
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
                      Icons.map,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Update Location"),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateLocation(
                                  uid: widget.uid,
                                ))).then((result) {
                      Navigator.of(context).pop();
                    });
                  },
                ),
                ListTile(
                  trailing: Transform.scale(
                      scale: 1,
                      child: Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blueGrey,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.blueGrey,
                      )),
                  title: Text("Availability"),
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
        title: Text("Home Page"),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RequestDonor(
                        uid: widget.uid,
                      ))).then((result) {
            Navigator.of(context).pop();
          });
        },
        child: Icon(Icons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Vikram"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified),
                ],
              ),
              subtitle: Column(
                children: <Widget>[
                  Container(
                      child: Column(children: <Widget>[
                    Text(
                        "No. of times donated - 5 \nDate - 05/05/2021 \nReason - Accident"),
                    new Row(
                      children: <Widget>[
                        new RaisedButton(
                          child: _hasBeenPressed1
                              ? Text("accepted")
                              : Text("accept"),

                          // 2
                          color: _hasBeenPressed1 ? Colors.blue : Colors.grey,
                          // 3
                          onPressed: () => {
                            setState(() {
                              _hasBeenPressed1 = !_hasBeenPressed1;
                            }),
                            showAlertDialog1(context)
                          },
                        ),
                      ],
                    ),
                  ]))
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("David"),
            subtitle: Column(
              children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  Text(
                      "No. of times donated - 5 \nDate - 02/05/2021 \nReason - Requirement in surgery"),
                  new Row(
                    children: <Widget>[
                      new RaisedButton(
                        child:
                            _hasBeenPressed ? Text("accepted") : Text("accept"),

                        // 2
                        color: _hasBeenPressed ? Colors.blue : Colors.grey,
                        // 3
                        onPressed: () => {
                          setState(() {
                            _hasBeenPressed = !_hasBeenPressed;
                          }),
                          showAlertDialog(context)
                        },
                      ),
                    ],
                  ),
                ]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the list options

  // set up the SimpleDialog
  Widget optionOne = SimpleDialogOption(
    child: const Text('Call 9542035039'),
    onPressed: () => launch("tel:+919542035039"),
  );
  SimpleDialog dialog = SimpleDialog(
    title: const Text('confirm?'),
    children: <Widget>[
      optionOne,
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

showAlertDialog1(BuildContext context) {
  // set up the list options

  // set up the SimpleDialog
  Widget optionOne = SimpleDialogOption(
    child: const Text('Call 6232072978'),
    onPressed: () => launch("tel:+916232072978"),
  );
  SimpleDialog dialog = SimpleDialog(
    title: const Text('confirm?'),
    children: <Widget>[
      optionOne,
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
