import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      height: 100.0,
      width: 120.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/IMG-20200821-WA0037.jpg'),
          fit: BoxFit.fill,
        ),
        //shape: BoxShape.circle,
      ),

      // child: Center(
      //   child: Text('Home screen',
      //     style: TextStyle(fontSize: 25.0),
      //   ),
      //
      // ),
    );
  }
}