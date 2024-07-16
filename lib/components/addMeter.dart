import 'package:flutter/material.dart';
import 'dart:math';

class AddMeterPage extends StatefulWidget {
  @override
  _AddMeterPageState createState() => _AddMeterPageState();
}

class _AddMeterPageState extends State<AddMeterPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _flats = [];
  int _flatCounter = 1;

  int _generateMeterId() {
    return Random().nextInt(1000000);
  }

  late int _meterId;

  @override
  void initState() {
    super.initState();
    _meterId = _generateMeterId();
    _addFlat(); // Automatically add one flat input field
  }

  void _addFlat() {
    setState(() {
      _flats.add({
        'flatNo': _flatCounter++,
        'houseNo': '',
        'email': '',
        'role': 'Owner',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Meter'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)], // Gradient colors
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Meter ID: $_meterId',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _flats.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Flat No: ${_flats[index]['flatNo']}',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'House No',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid house number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _flats[index]['houseNo'] = value!;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Flat No',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid flat number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _flats[index]['flatNo'] = value!;
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Resident Email',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _flats[index]['email'] = value!;
                            },
                          ),
                          SizedBox(height: 10.0),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Role',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            value: _flats[index]['role'],
                            items: ['Owner', 'Tenant'].map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _flats[index]['role'] = value;
                              });
                            },
                            onSaved: (value) {
                              _flats[index]['role'] = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Implement the logic to save meter and flats information
                    print('Meter ID: $_meterId');
                    _flats.forEach((flat) {
                      print('Flat No: ${flat['flatNo']}, House No: ${flat['houseNo']}, Email: ${flat['email']}, Role: ${flat['role']}');
                    });
                  }
                },
                child: Text('Save Meter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Add Meter App',
    home: AddMeterPage(),
  ));
}
