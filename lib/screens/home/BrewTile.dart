import 'package:brew_app/models/BrewModel.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final BrewModel brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(brew.name),
            subtitle: Text('Takes ${brew.sugars} sugars'),
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[this.brew.strength],
              backgroundImage: NetworkImage('https://picsum.photos/200'),
            ),
          ),
        ),
    );
  }
}
