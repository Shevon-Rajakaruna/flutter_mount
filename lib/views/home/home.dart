import 'package:flutter_mount/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mount/views/home/checkin.dart';
import 'package:flutter_mount/views/home/checkin_view.dart';
import 'package:flutter_mount/views/home/checkout.dart';
import 'package:flutter_mount/views/home/checkout_view.dart';
import 'package:flutter_mount/views/home/customer_view.dart';
import 'package:flutter_mount/views/home/home_screen.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    // return StreamProvider<List<Brew>>.value(
    //   value: DatabaseService().customers,
    //   child: Scaffold(
    //     backgroundColor: Colors.blueAccent[50],
    //     appBar: AppBar(
    //       title: Text('The Mount Camellia'),
    //       backgroundColor: Colors.blueAccent[400],
    //       elevation: 0.0,
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(Icons.person),
    //           label: Text('logout'),
    //           onPressed: () async {
    //             await _auth.signOut();
    //           },
    //         ),
    //       ],
    //     ),
    //     // body:
    //   ),
    // );

    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home"),
                Tab(icon: Icon(Icons.group), text: "Customers"),
                Tab(icon: Icon(Icons.add_shopping_cart), text: "Check In"),
                Tab(icon: Icon(Icons.shopping_cart), text: "Check Out"),
              ],
            ),
            title: Text('The Mount Camellia'),
            backgroundColor: Colors.blueAccent[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              CustomerView(),
              CheckinView(),
              CheckOutView(),
            ],
          ),
        ),
      ),
    );
  }
}