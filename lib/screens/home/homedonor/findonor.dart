import 'package:app/screens/home/homedonor/home.dart';
import 'package:app/screens/home/homedonor/updatelocation.dart';
import 'package:app/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/screens/service/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class FindDonor extends StatefulWidget {
//update the constructor to include the uid
  final String title;
  final String uid;
  final String requestid;//include this
  FindDonor({Key key, this.title, this.uid, this.requestid}) : super(key: key);

  @override
  _FindDonorState createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  DocumentSnapshot variable;
  DocumentSnapshot request;
  Future <QuerySnapshot> donlist;
  var collectionReference = Firestore.instance.collection('userInfo');
  final geo = Geoflutterfire();
  var queryref ;
  Future<List<DocumentSnapshot>> listss;
  int b = 0;


  void dte()async{
    request = await Firestore.instance
        .collection('request')
        .document(widget.requestid)
        .get();

    queryref = Firestore.instance.collection('userInfo')
        .where('age', isGreaterThanOrEqualTo: request.data['min age'])
        .where('bloodgroup', isEqualTo: request.data['blood group']);
    listss = geo
        .collection(collectionRef: queryref)
        .within(center: request.data['location'], radius: request.data['maxdistance'], field: 'location').first;

    print(listss);
    b = 1;

  }



  void database() async {
    variable = await Firestore.instance
        .collection('userInfo')
        .document(widget.uid)
        .get();
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


  @override
  void initState() {

    dte();
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
        title: Text("Nearby Donors"),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () async {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage(
            title: variable.data['name'],
            uid: this.widget.uid,
          )))
              .then((result) {
            Navigator.of(context).pop();
          });
        },
        child: Icon(Icons.home, color: Colors.white),
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
                              onPressed: () async{

                                await Firestore.instance.collection("request_donor").add({

                                  'donoremail': "exampleemail2",
                                  'requestid' : request.data['email'],
                                });
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
