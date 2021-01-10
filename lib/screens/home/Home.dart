import 'package:brew_app/models/BrewModel.dart';
import 'package:brew_app/screens/home/BrewList.dart';
import 'package:brew_app/services/DatabaseService.dart';
import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BrewModel>>.value(
      value: DatabaseService().notifyIfTheresChanged,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text(
            'Brew App',
          ),
          elevation: 0.0,
          centerTitle: false,
          brightness: Brightness.dark,
          backgroundColor: Colors.brown[400],
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await this._auth.signOut();
              },
              label: Text('Logout', style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.person, color: Colors.white,),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
