import 'package:bj_text/home_page.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  TextEditingController controllerMessage = TextEditingController();
  TextEditingController controllerRecipents = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String message;
  String recipents;


  @override
  Widget build (BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: controllerMessage,
                  decoration: InputDecoration(
                    labelText: "Message:"
                    ),
                  onChanged: (text){
                  message = text;
                  },
                  onSaved: (input) => message = input,
                ),
                TextFormField(
                  controller: controllerRecipents,
                  decoration: InputDecoration(
                    labelText: "Phone Number:"
                    ),
                  keyboardType: TextInputType.number,
                  validator: (input) => input.length < 10 ? 'Invalid Phone Number' : null,
                  onChanged: (text){
                  message = text;
                  },
                  onSaved: (input) => recipents = input,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: _saveDetails,
                        child: Text('Save'),
                      ),
                     )
                  ],
                )
              ],
            )
          ),
        )
      )
    );
  }

void _saveDetails() {
  if(_formKey.currentState.validate()){
    _formKey.currentState.save();
    setState(() {
      recipents.toList();
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(message: message, recipents: recipents),
      ));
  }
}

}