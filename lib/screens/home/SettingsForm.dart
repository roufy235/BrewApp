import 'package:brew_app/models/User.dart';
import 'package:brew_app/services/DatabaseService.dart';
import 'package:brew_app/shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Container(
      padding: EdgeInsets.all(10.0),
      child: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).getUserDoc,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            UserData user = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentName ?? user.name,
                    validator: (val) {
                      return val.isNotEmpty ? null : 'Please enter a name';
                    },
                    onChanged: (val) {
                      setState(() {
                        this._currentName = val;
                      });
                    },
                    decoration: InputDecoration(hintText: 'Enter name'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  DropdownButtonFormField(
                    value: this._currentSugar ?? user.sugars,
                    onChanged: (val) {
                      setState(() {
                        this._currentSugar = val;
                      });
                    },
                    hint: Text('Select'),
                    items: this.sugars.map((String sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Slider(
                    value: (this._currentStrength ?? user.strength).toDouble(),
                    activeColor: Colors.brown[this._currentStrength ?? user.strength],
                    inactiveColor: Colors.brown[this._currentStrength ?? user.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        this._currentStrength = val.round();
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    color: Colors.brown[400],
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {}
                    },
                    child: Text(
                      'Update',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        }
      ),
    );
  }
}
