import 'package:flutter/material.dart';
import 'package:flutter_mount/services/database.dart';
import 'package:flutter_mount/views/home/customer_view.dart';
import 'package:flutter_mount/views/home/home.dart';

class CustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: appTitle,
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
          body: CustomerAddForm(),
        ),
      ),
    );
  }
}

class CustomerAddForm extends StatefulWidget {
  @override
  CustomerAddFormState createState() {
    return CustomerAddFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CustomerAddFormState extends State<CustomerAddForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _address;
  String _phone;
  String _email;
  String _nic;

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
                  //color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                //fillColor: Colors.white, filled: true,
                hintText: 'Add Customers',
                contentPadding: const EdgeInsets.all(20.0),
              ),
            ),
          ),

          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Name",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Customer name';
                }
                return null;
              },
              onChanged: (val) {
                _name = val;
              },
            ),
          ),

          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Address",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter address';
                }
                return null;
              },
              onChanged: (val) {
                _address = val;
              },
            ),
          ),

          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter phone number';
                }
                return null;
              },
              onChanged: (val) {
                _phone = val;
              },
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "Email",
              ),
              validator: (value) {
                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'Please enter valid email.';
                }
                return null;
              },
              onChanged: (val) {
                _email = val;
              },
            ),
          ),

          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextFormField(
              decoration: new InputDecoration(
                hintText: "NIC",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter NIC';
                }
                return null;
              },
              onChanged: (val) {
                _nic = val;
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

                    DatabaseService().updateCustomerData(_name, _address, _phone, _email, _nic);

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