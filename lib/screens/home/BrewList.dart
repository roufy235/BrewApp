import 'package:brew_app/models/BrewModel.dart';
import 'package:brew_app/screens/home/BrewTile.dart';
import 'package:brew_app/shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewModel>>(context);
    return brews == null ? Center(child: Loading()) : ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index],);
      },
    );
  }
}
