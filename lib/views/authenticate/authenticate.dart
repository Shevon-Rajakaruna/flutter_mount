import 'package:flutter_mount/views/authenticate/register.dart';
import 'package:flutter_mount/views/authenticate/login.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LogIn(toggleView:  toggleView);
    } else {
      return Register(toggleView:  toggleView);
    }
  }
}