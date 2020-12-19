import 'package:flutter_mount/models/user.dart';
import 'package:flutter_mount/views/authenticate/authenticate.dart';
import 'package:flutter_mount/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    // if (user == null){
    //   return Authenticate();
    // } else {
      return Home();
    //}

  }
}