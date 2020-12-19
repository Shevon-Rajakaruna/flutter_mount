import 'package:flutter/material.dart';
import 'package:flutter_mount/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'views/wrapper.dart';

// import 'package:flutter_mount/views/home/home_screen.dart';
// import 'package:flutter_mount/views/home/customer.dart';
// import 'package:flutter_mount/views/home/checkin.dart';
// import 'package:flutter_mount/views/home/checkout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}


// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 4,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(
//               tabs: [
//                 Tab(icon: Icon(Icons.home), text: "Home"),
//                 Tab(icon: Icon(Icons.group), text: "Customers"),
//                 Tab(icon: Icon(Icons.add_shopping_cart), text: "Check In"),
//                 Tab(icon: Icon(Icons.shopping_cart), text: "Check Out"),
//               ],
//             ),
//             title: Text('Mount Camellia'),
//           ),
//           body: TabBarView(
//             children: [
//               HomeScreen(),
//               CustomerScreen(),
//               CheckInScreen(),
//               CheckOutScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

