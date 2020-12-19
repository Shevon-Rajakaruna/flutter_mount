import 'package:flutter_mount/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference customersCollection = Firestore.instance.collection('customers');
  final CollectionReference checkinCollection = Firestore.instance.collection('checkins');
  final CollectionReference checkoutCollection = Firestore.instance.collection('checkouts');

  Future<void> updateCustomerData(String name, String address, String phone, String email,String nic) async {
    return await customersCollection.document().setData({
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'nic': nic,
    });
  }

  Future<void> updateCheckinData(String customer, DateTime ddate, int singler, int doubler,int familyr, int totalr, String additional, String remarks) async {
    return await checkinCollection.document().setData({
      'customer': customer,
      'ddate': ddate,
      'singler': singler,
      'doubler': doubler,
      'familyr': familyr,
      'totalr': totalr,
      'additional': additional,
      'remarks': remarks,
    });
  }

  Future<void> createCheckoutData(String customer, DateTime checkout_date, double room_charges, double food_charges, double other, double discount, double total, bool checked_out) async {
    return await checkoutCollection.document().setData({
      'customer': customer,
      'checkout_date': checkout_date,
      'room_charges': room_charges,
      'food_charges': food_charges,
      'other': other,
      'discount': discount,
      'total': total,
      'checked_out': checked_out,
    });
  }

  Future<void> updateCheckoutData(String customer, DateTime checkout_date, double room_charges, double food_charges, double other, double discount, double total, bool checked_out , String doc_id) async {
    return await checkoutCollection.document(doc_id).setData({
      'customer': customer,
      'checkout_date': checkout_date,
      'room_charges': room_charges,
      'food_charges': food_charges,
      'other': other,
      'discount': discount,
      'total': total,
      'checked_out': checked_out,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get customers {
    return customersCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

}