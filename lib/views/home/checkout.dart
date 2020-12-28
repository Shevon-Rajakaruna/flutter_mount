import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_mount/services/database.dart';
import 'package:flutter_mount/views/home/home.dart';
import 'package:intl/intl.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:flutter/material.dart';


class CheckOutScreen extends StatelessWidget {
  static var document_id;

  CheckOutScreen(String documentID){
    document_id = documentID;

  }

  @override
  Widget build(BuildContext context) {
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
                  //await _auth.signOut();
                },
              ),
            ],
          ),
          body: CheckOutAddForm(),
        ),
      ),
    );
  }
}

class CheckOutAddForm extends StatefulWidget {
  @override
  CheckOutAddFormState createState() {
    return CheckOutAddFormState();
  }
}

class CheckOutAddFormState extends State<CheckOutAddForm> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  dynamic data;

  String _customer;
  DateTime _cdate;
  double _rcharges = 0.0;
  double _fcharges = 0.0;
  double _other = 0.0;
  double _discount = 0.0;
  double _total = 0.0;
  bool _checked_out = true;

  double getTotal(){
    return _total = (_rcharges + _fcharges + _other) - _discount;
  }

  //ref: https://stackoverflow.com/questions/59529177/how-to-read-data-from-firestore-flutter
  Future<dynamic> getData() async {
    final DocumentReference document =   Firestore.instance.collection("checkouts").document(CheckOutScreen.document_id);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
        _customer = snapshot.data['customer'];
        _cdate = snapshot.data['checkout_date'];
        _rcharges = snapshot.data['room_charges'];
        _fcharges = snapshot.data['food_charges'];
        _other = snapshot.data['other'];
        _discount = snapshot.data['discount'];
        _total = snapshot.data['total'];
        _checked_out = snapshot.data['checked_out'];
      });
    });
  }

  @override
  void initState() {

    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    print(_customer);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            title: new TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Customer Check Out',
                contentPadding: const EdgeInsets.all(20.0),
              ),
            ),
          ),

          new ListTile(
            leading: Text('Customer'),
            title: new TextFormField(
              decoration: new InputDecoration(
                //hintText: "CustomerName",
              ),
              controller: TextEditingController()..text = _customer,
              // initialValue: _customer,
              onTap: (){
                setState(() {
                  controller: TextEditingController()..text = _customer;
                });
              },
              // readOnly: true,
            ),
          ),

          // ref: https://pub.dev/packages/datetime_picker_formfield
          new ListTile(
            leading: Text('Date'),
            title: DateTimeField(
              format: format,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2010),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2030));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  _cdate = DateTimeField.combine(date, time);
                  return _cdate;
                } else {
                  return currentValue;
                }
              },
            ),
          ),

          new ListTile(
            leading: Text('Room Charges'),
            title: new TextFormField(
              keyboardType: TextInputType.number,
              // decoration: new InputDecoration(
              //   hintText: "Total Room Charges",
              // ),
              controller: TextEditingController()..text = _rcharges.toString(),
              onChanged: (val) {
                _rcharges = double.parse(val);

                // setState(() {
                //   _total = _total + _rcharges;
                // });
              },
            ),
          ),

          new ListTile(
            leading: Text('Beverage Charges'),
            title: new TextFormField(
              keyboardType: TextInputType.number,
              // decoration: new InputDecoration(
              //   hintText: "Total Beverage Charges",
              // ),
              controller: TextEditingController()..text = _fcharges.toString(),
              onChanged: (val) {
                _fcharges = double.parse(val);

                // setState(() {
                //   _total = _total + _fcharges;
                // });
              },
            ),
          ),

          new ListTile(
            leading: Text('Other Charges'),
            title: new TextFormField(
              keyboardType: TextInputType.number,
              // decoration: new InputDecoration(
              //   hintText: "No. of Family Rooms",
              // ),
              controller: TextEditingController()..text = _other.toString(),
              onChanged: (val) {
                _other = double.parse(val);

                // setState(() {
                //   _total = _total + _other;
                // });
              },
            ),
          ),

          new ListTile(
            leading: Text('Discount'),
            title: new TextFormField(
              // decoration: new InputDecoration(
              //   hintText: "Discount",
              // ),
              controller: TextEditingController()..text = _discount.toString(),
              onChanged: (val) {
                _discount = double.parse(val);
                // setState(() {
                //   _total = _total - _discount;
                // });
              },
            ),
          ),

          new ListTile(
            leading: Text('Total'),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Discount",
              ),
              controller: TextEditingController()..text = _total.toString(),
              // onChanged: (val) {
              //   _total = double.parse(val);
              //   print(_total);
              // },
              onTap: (){
                setState(() {
                  _total = this.getTotal();
                  controller: TextEditingController()..text = _total.toString();
                });
              },
              readOnly: true,
            ),
          ),

          //ref: https://pub.dev/packages/checkbox_formfield/example
          new ListTile(
            //leading: const Icon(Icons.person),
            title: new CheckboxListTileFormField(
              title: Text('Checked Out'),
              initialValue: _checked_out,
              onSaved: (bool value) {_checked_out = value;},
              validator: (bool value) {
                _checked_out = value;
                if (value) {
                  return null;
                } else {
                  return 'False!';
                }
              },
            ),
          ),

          new ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing Data')));

                    print(_checked_out);

                    DatabaseService().updateCheckoutData(_customer, _cdate, _rcharges, _fcharges, _other, _discount, _total, _checked_out, CheckOutScreen.document_id);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ),

          // TextFormField(
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          // ),

        ],
      ),
    );
  }
}