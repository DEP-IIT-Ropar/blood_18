import 'dart:math';
import 'package:app/screens/home/homedonor/requestdonor.dart';
import 'package:app/screens/home/homedonor/updatelocation.dart';
import 'package:app/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


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
  List<DocumentSnapshot> request = List<DocumentSnapshot>();
  List<DocumentSnapshot> seekers = List<DocumentSnapshot>();
  DocumentSnapshot seeker;
  var stream;
  var variablee;
  var requestId;
  var len;
  var state, state1;
  int _value = 1;

  var isRequested = [false, false];
  bool isSwitched = false;

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
    setState(() {
      variablee = variable;
    });
  }

  void getData() async{
    if(_value == 1){
    stream = await Firestore.instance
        .collection('request_donor')
        .where('donoremail', isEqualTo: widget.uid).orderBy('distance')
        .getDocuments();}
    if(_value == 2){
    stream = await Firestore.instance
        .collection('request_donor')
        .where('donoremail', isEqualTo: widget.uid).orderBy('date')
        .getDocuments();}



    requestId = stream.documents.map((doc)=>doc.data).toList();
    print(stream);

    len = requestId.length;
    int index = 0;

    for(index = 0; index < len; index++){
      print(await Firestore.instance.collection('request').document(requestId[index]['requestid']).get());
      var abcd = await Firestore.instance.collection('request').document(requestId[index]['requestid']).get();
      request.add(abcd);
    }
    print(request);
    for(index = 0; index < len; index++){
      seekers.add(await Firestore.instance.collection('userInfo').document(request[index]['email']).get());
    }
    print(seekers);
    setState(() {
      state = request;
      state1 = seekers;
    });
    index = 0;


  }

  var textValue = 'Switch is OFF';


  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      setState(() async {
        await Firestore.instance
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
        await Firestore.instance
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
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //getData();
    if(variable != null && requestId != null && request != null && seekers != null){
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
        body: Column(
          children: <Widget>[
            DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("sort by distance"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("sort by date"),
                    value: 2,
                  ),

                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                  getData();
                }),
            ListView.builder(
                shrinkWrap: true,
                itemCount: request.length,
                itemBuilder: (context, index){
                  if(isRequested.length <= index) isRequested.add(false);
                  return Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.green[200],
                        //backgroundImage: AssetImage('assets/O+.png'),
                      ),
                      title: Text(seekers[index].data['name']),
                      subtitle: Column(
                        children: <Widget>[

                          Text(
                              '${roundDouble(requestId[index]['distance'], 1)} km away \nAge-${seekers[index]['age']}  \nNo. of times Donated-${seekers[index]['#donated']}\nreason-${request[index]['reason']}'),

                          new RaisedButton(child: isRequested[index]
                              ? Text("Accepted")
                              : Text("Accept"),

                            // 2
                            color: isRequested[index] ? Colors.blue : Colors.grey,

                            // 3
                            onPressed: () => {
                              if(isRequested[index] == false){
                                  showAlertDialog(context,seekers[index]['phone'])
                              },
                              setState(() {
                                isRequested[index] = true;
                              }),


                            }
                          ),



                        ],
                      ),

                    )
                  );
                }
            )
          ]
        )
        /*body: StreamBuilder(
          stream: stream
          ,
          /*builder: (context, userSnapshot) {

            return userSnapshot.hasData
                ? ListView.builder(
                itemCount: userSnapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot userData =
                  userSnapshot.data.documents[index];
                  request = await Firestore.instance
                      .collection('request')
                      .document(userData.data['requestid'])
                      .get();
                  seeker = await Firestore.instance
                      .collection('userInfo')
                      .document(request.data['email'])
                      .get();
                  return Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.green[200],
                        //backgroundImage: AssetImage('assets/O+.png'),
                      ),
                      title: Text(seeker.data['name']),
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                              'Date-${userData.data['date']} \n#donated-${seeker.data['#donated']}'),
                          /*RaisedButton(
                          child: isRequested[index]
                              ? Text("Requested")
                              : Text("Request"),

                          // 2
                          color: isRequested[index] ? Colors.blue : Colors.grey,
                          // 3
                          /*onPressed: () => {
                            if (isRequested[index] == false)
                              {
                                addrequestdonor(stream[index].data['email'],
                                    widget.requestid)
                              },
                            setState(() {
                              isRequested[index] = true;
                            }),
                          },*/
                        )*/
                        ],
                      ),
                    ),
                  );

                })
                : CircularProgressIndicator();
          },*/
        ),*/
      );}else{
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
          body: Center(
            child: Text("No Requests"),
          )
      );
    }
  }
  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  /*showAlertDialog(String phone){
    Widget optionOne = SimpleDialogOption(
      child: Text('Call $phone'),
      onPressed: () => launch("tel:$phone"),
    );
    SimpleDialog dialog = SimpleDialog(
      title: const Text('confirm?'),
      children: <Widget>[
        optionOne,
      ],
    );
    return dialog;
  }*/
}

/*showAlertDialog(String phone) {
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

}*/

showAlertDialog(BuildContext context, String phone) {
  // set up the list options

  // set up the SimpleDialog
  Widget optionOne = SimpleDialogOption(
    child: Text('Call $phone'),
    onPressed: () => launch("tel:$phone"),
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

/*import 'package:app/screens/home/homedonor/requestdonor.dart';
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
*/