import 'package:app/screens/home/homedonor/findonor.dart';
import 'package:app/screens/login/login.dart';
import 'package:app/screens/seeker/homeseek.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/screens/service/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DonorList extends StatefulWidget {
  final FirebaseUser user;

  DonorList({this.user});
  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
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
                  accountName: Text('User Name'),
                  accountEmail: Text(
                    "${widget.user.phoneNumber}",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[400],
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Request Status"),
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
        title: Text("Nearby Donors"),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeSeek(
                        user: widget.user,
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
              title: Text("Mohit Keshri"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified),
                  Text(
                    "4.5",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              subtitle: Column(
                children: <Widget>[
                  Container(
                      child: Column(children: <Widget>[
                    Text(
                        "No. of times donated - 5 \nLast Donated - 10/04/2021 \nAlcohalic/Smoker - NO"),
                    new Row(
                      children: <Widget>[
                        new RaisedButton(
                          child: Text("Request"),
                          onPressed: () {},
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
            title: Text("Prakash Raj"),
            trailing: Text(
              "4.5",
              style: TextStyle(color: Colors.green),
            ),
            subtitle: Column(
              children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  Text(
                      "No. of times donated - 5 \nLast Donated - 14/04/2021 \nAlcohalic/Smoker - Yes"),
                  new Row(
                    children: <Widget>[
                      new RaisedButton(
                        child: Text("Request"),
                        onPressed: () {},
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
  Widget optionOne = SimpleDialogOption(
    child: const Text('YES'),
    onPressed: () {},
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('NO'),
    onPressed: () {},
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Are you sure to request?'),
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
