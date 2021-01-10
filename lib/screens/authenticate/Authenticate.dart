import 'package:brew_app/screens/authenticate/CreateAccount.dart';
import 'package:brew_app/screens/authenticate/SignIn.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => this.showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn ? SignIn(toggleView : toggleView) : CreateAccount(toggleView : toggleView),
    );
  }
}
