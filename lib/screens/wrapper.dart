import 'package:brew_app/models/User.dart';
import 'package:brew_app/screens/authenticate/Authenticate.dart';
import 'package:brew_app/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // return either Home or Authenticate widget
    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
