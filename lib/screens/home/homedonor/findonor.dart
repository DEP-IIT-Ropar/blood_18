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
  final String requestid; //include this
  FindDonor({Key key, this.title, this.uid, this.requestid}) : super(key: key);

  @override
  _FindDonorState createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  DocumentSnapshot variable;
  DocumentSnapshot request;
  Future<QuerySnapshot> donlist;
  var collectionReference = Firestore.instance.collection('userInfo');
  final geo = Geoflutterfire();
  var queryref;
  Future<List<DocumentSnapshot>> listss;
  int b = 0;

  void database() async {
    variable = await Firestore.instance
        .collection('userInfo')
        .document(widget.uid)
        .get();
  }

  void dte() async {
    request = await Firestore.instance
        .collection('request')
        .document(widget.requestid)
        .get();

    queryref = Firestore.instance
        .collection('userInfo')
        .where('age', isGreaterThanOrEqualTo: request.data['min age'])
        .where('bloodgroup', isEqualTo: request.data['blood group'])
        .snapshots();
    listss = geo
        .collection(collectionRef: queryref)
        .within(
            center: request.data['location'],
            radius: request.data['maxdistance'],
            field: 'location')
        .first;

    b = 1;
  }

  /*void database() async {
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
  }*/

  @override
  void initState() {
    database();
    dte();
    print(listss);
    super.initState();
  }

  Widget _buildList1(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.green[200],
        //backgroundImage: AssetImage('assets/O+.png'),
      ),
      title: Text(document.data['name']),
      subtitle: Text(document.data['phone']),
    );
  }

  @override
  Widget buildUserList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            DocumentSnapshot user = snapshot.data.documents[index];
            return Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: _buildList1(context, user));
          });
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No users found."),
      );
    } else {
      // Still loading
      return LinearProgressIndicator();
    }
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
                                  builder: (context) => LoginPage()))
                          .then((result) {
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
          title: Text("Nearby Donors for ${widget.title}"),
          backgroundColor: Colors.red[400],
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[400],
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          //title: variable.data['name'],
                          uid: this.widget.uid,
                        ))).then((result) {
              Navigator.of(context).pop();
            });
          },
          child: Icon(Icons.home, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: StreamBuilder(
          stream: queryref,
          builder: buildUserList,
        ));
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
