import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mount/views/home/checkout.dart';
import 'package:intl/intl.dart';

class CheckOutView extends StatelessWidget {

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const Icon(Icons.check_circle_outlined, color: Colors.green, size: 40,),
          title: Text(document['customer']),
          // subtitle: Text('Checking Out : ${DateFormat('yyyy-MM-dd – kk:mm').format(document['checkout_date'].toDate() ?? '2020-12-12')}'),
          subtitle: Text('Checking Out - Cost: ${document['total']}'),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckOutScreen(document.documentID)),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(

        stream: Firestore.instance.collection('checkouts').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildListItem(context , snapshot.data.documents[index]),
          );
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => CheckOutScreen()),
      //     );
      //   },
      //   tooltip: 'Check Out Customers',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}