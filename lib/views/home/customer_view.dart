import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mount/views/home/customer.dart';

class CustomerView extends StatelessWidget {

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(document['name']),
          subtitle: Text(document['phone']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(

          stream: Firestore.instance.collection('customers').snapshots(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerScreen()),
          );
        },
        tooltip: 'Add Customers',
        child: Icon(Icons.add),
      ),
    );
  }
}