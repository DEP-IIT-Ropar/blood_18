import 'package:app/screens/home/homedonor/findonor.dart';
import 'package:app/screens/home/homedonor/updatelocation.dart';
import 'package:app/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/screens/service/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'dart:collection';
import 'package:geoflutterfire/geoflutterfire.dart';

class RequestDonor extends StatefulWidget {
  final String title;
  final String uid; //include this
  RequestDonor({Key key, this.title, this.uid}) : super(key: key);

  @override
  _RequestDonorState createState() => _RequestDonorState();
}

class _RequestDonorState extends State<RequestDonor> {
  TextEditingController dateCtl = TextEditingController();
  var newFormat = DateFormat("yy-MM-dd");
  String updatedDt;
  DocumentSnapshot variable, variablee;
  void database1() async {
    variable = await Firestore.instance
        .collection('userInfo')
        .document(widget.uid)
        .get();
    setState(() {
      variablee = variable;
    });
  }

  @override
  void initState() {
    database1();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  final _nameController = TextEditingController();
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;
  bool _isMarker = false;
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  LatLng position;
  GeoFirePoint seekerlocation;
  String bloodgrp;
  String dist;
  String minage;
  String seekername;
  String seekerage;
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

  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  List<Marker> myMarker = [];

  @override
  Widget build(BuildContext context) {
    if (variable != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tap To Mark Your Location"),
          backgroundColor: Colors.red[400],
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[400],
          onPressed: () => _regis(),
          child: Icon(Icons.search, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                CameraPosition(target: _initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                markers: Set.from(myMarker),
                onTap: _handleTap,
                myLocationEnabled: true,
              ),
            ],
          ),
        ),
      );
    }
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
      position = tappedPoint;
      print(position);
      seekerlocation = Geoflutterfire()
          .point(latitude: position.latitude, longitude: position.longitude);
    });
  }

  void _regis() async {
    /*var pos = await _location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;*/
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                          hintText: "Enter the seeker's name",
                        ),
                        validator: (val) =>
                        val.isEmpty ? "Enter the seeker's name" : null,
                        onChanged: (val) {
                          setState(() => seekername = val);
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
                          hintText: "Enter the seeker's age",
                        ),
                        validator: (val) =>
                        val.isEmpty ? "Enter the seeker's age" : null,
                        onChanged: (val) {
                          setState(() => seekerage = val);
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
                      controller: dateCtl,
                      decoration: InputDecoration(
                        hintText: "Date needed by",
                      ),
                      onTap: () async {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));

                        updatedDt = newFormat.format(date);
                        dateCtl.text = updatedDt;
                      },
                    ),
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
                          hintText: 'Enter the reason and remarks',
                        ),
                        validator: (val) =>
                        val.isEmpty ? 'Enter the reason and remarks' : null,
                        onChanged: (val) {
                          setState(() => _nameController.text = val);
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
                          hintText: 'Enter Maximum distance in km',
                        ),
                        validator: (val) =>
                        val.isEmpty ? 'Enter Maximum distance in km' : null,
                        onChanged: (val) {
                          setState(() => dist = val);
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
                          hintText: 'Enter Minimum Age',
                        ),
                        validator: (val) =>
                        val.isEmpty ? 'Enter Minimum Age' : null,
                        onChanged: (val) {
                          setState(() => minage = val);
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
                          hintText: 'Required Blood Group',
                        ),
                        items: bloodgrps.map((bloodgrp) {
                          return DropdownMenuItem(
                            value: bloodgrp,
                            child: Text('$bloodgrp'),
                          );
                        }).toList(),
                        validator: (val) =>
                        val.isEmpty ? 'Select blood group' : null,
                        onChanged: (val) {
                          setState(() => bloodgrp = val);
                        }),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () async {
                      var variable = await Firestore.instance
                          .collection('userInfo')
                          .document(widget.uid)
                          .get();
                      final requestid =
                      await Firestore.instance.collection("request").add({
                        'blood group': bloodgrp,
                        'name': seekername,
                        'age': int.parse(seekerage),
                        'email': this.widget.uid,
                        'phone': variable.data['phone'],
                        'location': seekerlocation.data,
                        'maxdistance': int.parse(dist),
                        'min age': int.parse(minage),
                        'reason': _nameController.text,
                        'type': "user",
                        'date_needed': dateCtl.text,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindDonor(
                                title: bloodgrp,
                                uid: widget.uid,
                                requestid: requestid.documentID,
                              ))).then((result) {
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
                          'Find'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}