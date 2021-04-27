import 'package:app/screens/home/homedonor/findmap.dart';
import 'package:app/screens/login/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.uid}) : super(key: key);
  //update the constructor to include the uid
  final String title;
  final String uid; //include this
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  accountName: Text('User name'),
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
                      Icons.map,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text("Update Location"),
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
        title: Text("Home Page"),
        backgroundColor: Colors.red[400],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () async {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FindLocation()))
              .then((result) {
            Navigator.of(context).pop();
          });
        },
        child: Icon(Icons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                        "No. of times donated - 5 \nLast Donated - 14/04/2021 \nAlcohalic/Smoker - Yes"),
                    new Row(
                      children: <Widget>[
                        new RaisedButton(
                          child: Text("Accept"),
                          onPressed: () {},
                        ),
                        Divider(
                          thickness: 20,
                        ),
                        new RaisedButton(
                          child: Text("Decline"),
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
            title: Text("David"),
            trailing: Text(
              "4",
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
                        child: Text("Accept"),
                        onPressed: () {},
                      ),
                      Divider(
                        thickness: 20,
                      ),
                      new RaisedButton(
                        child: Text("Decline"),
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
    onPressed: () {
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()))
          .then((result) {
        Navigator.of(context).pop();
      });
    },
  );
  Widget optionTwo = SimpleDialogOption(
    child: const Text('NO'),
    onPressed: () {
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()))
          .then((result) {
        Navigator.of(context).pop();
      });
    },
  );

  // set up the SimpleDialog
  SimpleDialog dialog = SimpleDialog(
    title: const Text('Willing to donate?'),
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
