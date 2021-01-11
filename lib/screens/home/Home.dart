import 'package:brew_app/models/BrewModel.dart';
import 'package:brew_app/screens/home/BrewList.dart';
import 'package:brew_app/screens/home/SettingsForm.dart';
import 'package:brew_app/services/DatabaseService.dart';
import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingsForm(),
      );
    });
  }

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
            GestureDetector(
              onTap: () async {
                await this._auth.signOut();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child: Icon(Icons.person, color: Colors.white,),
              ),
            ),
            GestureDetector(
                onTap: () => _showBottomSheet(context),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                  child: Icon(Icons.settings, color: Colors.white,),
                ),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
