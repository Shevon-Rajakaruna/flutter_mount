import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_mount/services/database.dart';
import 'package:flutter_mount/views/home/home.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CheckInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
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
          body: CheckInAddForm(),
        ),
      ),
    );
  }
}

class CheckInAddForm extends StatefulWidget {
  @override
  CheckInAddFormState createState() {
    return CheckInAddFormState();
  }
}

class CheckInAddFormState extends State<CheckInAddForm> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  String _customer;
  DateTime _ddate;
  int _singler = 0;
  int _doubler = 0;
  int _familyr = 0;
  int _totalr = 0;
  String _additional;
  String _remarks;
  double _roomcost = 0.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new ListTile(
            //leading: const Icon(Icons.person),
            title: new TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Customer Check In',
                contentPadding: const EdgeInsets.all(20.0),
              ),
            ),
          ),

          //ref: https://stackoverflow.com/questions/52823542/how-to-bind-a-firestore-documents-list-to-a-dropdown-menu-in-flutter
          new ListTile(
            leading: const Icon(Icons.person),
            title: new StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('customers').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return new DropdownButton<String>(
                  isDense: true,
                  hint: new Text("Select Customer..."),
                  value: _customer,
                  onChanged: (String newValue) {
                    _customer = newValue;
                    print (_customer);
                  },
                  items: snapshot.data.documents.map((DocumentSnapshot document) {
                    return new DropdownMenuItem<String>(
                        value: document.data['name'],
                        child: new Container(
                          // decoration: new BoxDecoration(
                          //     color: Colors.brown,
                          //     borderRadius: new BorderRadius.circular(5.0)
                          // ),
                          // height: 100.0,
                          padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                          //color: primaryColor,
                          child: new Text(document.data['name']),
                        )
                    );
                  }).toList(),
                );},
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
                  _ddate = DateTimeField.combine(date, time);
                  return _ddate;
                } else {
                  return currentValue;
                }
              },
              // onChanged: (dt) {
              //   _ddate = dt;
              // },
            ),
          ),

          //ref: https://flutter-examples.com/flutter-get-only-numeric-number-value-from-textfield/
          new ListTile(
            leading: Text('Single Rooms'),
            title: new TextFormField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: "No. of Single Rooms",
              ),
              onChanged: (val) {
                _singler = int.parse(val);
                _totalr = _totalr + _singler;
                _roomcost = _roomcost + double.parse((3000 * _singler).toString());
              },
            ),
          ),

          new ListTile(
            leading: Text('Double Rooms'),
            title: new TextFormField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: "No. of Double Rooms",
              ),
              onChanged: (val) {
                _doubler = int.parse(val);
                _totalr = _totalr + _doubler;
                _roomcost = _roomcost + double.parse((3500 * _doubler).toString());
              },
            ),
          ),

          new ListTile(
            leading: Text('Family Rooms'),
            title: new TextFormField(
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                hintText: "No. of Family Rooms",
              ),
              onChanged: (val) {
                _familyr = int.parse(val);
                _totalr = _totalr + _familyr;
                _roomcost = _roomcost + double.parse((4500 * _familyr).toString());
              },
            ),
          ),

          new ListTile(
            leading: Text('Total Rooms'),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Total Rooms",
              ),
              controller: TextEditingController()..text = _totalr.toString(),
              readOnly: true,
              //initialValue: _totalr.toString(),
            ),
          ),

          new ListTile(
            leading: Text('Additional'),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Additional Items",
              ),
              onChanged: (input) {
                _additional = input;
              },
            ),
          ),

          new ListTile(
            leading: Text('Remarks'),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Remarks",
              ),
              onChanged: (input) {
                _remarks = input;
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

                    DatabaseService().updateCheckinData(_customer, _ddate, _singler, _doubler, _familyr, _totalr, _additional, _remarks);
                    DatabaseService().createCheckoutData(_customer, null, _roomcost, 0.0, 0.0, 0.0, 0.0, false);

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

        ],
      ),
    );
  }
}