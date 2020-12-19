import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mount/views/home/checkin.dart';

class CheckinView extends StatelessWidget {

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
          title: Text(document['customer']),
          subtitle: Text('Total Rooms : ${document['totalr'].toString()}'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(

        stream: Firestore.instance.collection('checkins').snapshots(),
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
            MaterialPageRoute(builder: (context) => CheckInScreen()),
          );
        },
        tooltip: 'CheckIn Customers',
        child: Icon(Icons.add),
      ),
    );
  }
}