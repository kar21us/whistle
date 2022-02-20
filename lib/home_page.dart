import 'package:flutter/material.dart';
import 'settings.dart';

import 'package:flutter_sms/flutter_sms.dart';

import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {

  String message;
  List recipents;
  HomePage({Key key, this.message, this.recipents}) : super(key : key);
  

  @override
  _HomePageState createState() => _HomePageState(message, recipents);
}

class _HomePageState extends State<HomePage> {
  Position _currentPosition;
  String message;
  List recipents;

  _HomePageState(this.message, this.recipents);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                    Colors.red[900],
                    Colors.redAccent
                    ] 
                  ) 
                ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(padding: EdgeInsets.all(8.0),
                      child: Image.asset("images/bj.png", width: 75, height: 75),), 
                      ),
                      Padding(padding: EdgeInsets.all(8.0),child: Text("whistle", style: TextStyle(color:Colors.white, fontSize: 25.0) ,) ,
                      )
                    ],
                  )
                )
              ), 
            ListTile(
              title: Text("Home", style: TextStyle(fontSize:20 ),),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Settings", style: TextStyle(fontSize:20 ),),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new Settings()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.room),
              iconSize: 300,
              color: Colors.red[900],
              onPressed: () {
                _getCurrentLocation();
                //String message = "Kartik, your beloved Boyfriend, wants a blowjob. He is located at" + " " + "https://maps.google.com/?q=" + "${_currentPosition.latitude}" + "," + "${_currentPosition.longitude}";
                //List<String> recipents = ["14083068920"];
                _sendSMS(message, recipents[0]);
              },
            ),
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
  void _sendSMS(String message, List<String> recipents) async {
    try {
      String _result =
          await sendSMS(message: message, recipients: recipents);
    } catch (error) {

    }
    print(message);
  }
}