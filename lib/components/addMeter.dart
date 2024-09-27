import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AddMeterPage extends StatefulWidget {
  const AddMeterPage({super.key});

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
        'houseId': "",
        'currentResidentEmail': '',
        'currentResidentRole': 'Owner',
        'history': [{
          "date": DateTime.now().toIso8601String(),
          "volume": 0,
          "status": "low",
          "userEmail": "goru@gmail.com",
        }],
        "meterId": _meterId,
      });
    });
  }

  Future<void> addMeter(BuildContext context) async {
    try {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref("Meter").child(_meterId.toString());
      await dbRef.set(_flats[0]);

      DatabaseReference dbRef1 = FirebaseDatabase.instance.ref("House").child(_flats[0]["houseId"]);
      DatabaseReference dbPush = dbRef1.child("meters");
      final meterInHouse = {
        "currentResidentEmail": _flats[0]["currentResidentEmail"],
        "currentResidentRole": _flats[0]["currentResidentRole"],
        "flatNo": _flats[0]["flatNo"],
        "meterId": _meterId,
      };

      await dbPush.push().set({
        "meters": meterInHouse,
      });

      setState(() {
        _meterId = _generateMeterId();
      });

      ScaffoldMessenger.of(context.mounted ? context : context)
          .showSnackBar(const SnackBar(
        content: Text("Successfully added meter"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context.mounted ? context : context)
          .showSnackBar(const SnackBar(
        content: Text("Failed to add meter"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meter'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.blue.shade400,
              const Color.fromARGB(255, 130, 186, 221)
            ], // Gradient colors
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Meter ID: $_meterId',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _flats.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
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
                              _flats[index]['houseId'] = value!;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            decoration: const InputDecoration(
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
                          const SizedBox(height: 10.0),
                          TextFormField(
                            decoration: const InputDecoration(
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
                              _flats[index]['currentResidentEmail'] = value!;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Role',
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            value: _flats[index]['currentResidentRole'],
                            items: ['Owner', 'Tenant'].map((role) {
                              return DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _flats[index]['currentResidentRole'] = value;
                              });
                            },
                            onSaved: (value) {
                              _flats[index]['currentResidentRole'] = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Implement the logic to save meter and flats information
                    print('Meter ID: $_meterId');
                    addMeter(context);
                  }
                },
                child: const Text('Save Meter'),
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
