import 'package:flutter/material.dart';

class MeterDetailsPage extends StatelessWidget {
  final String meterId;

  MeterDetailsPage({required this.meterId});

  final List<Map<String, dynamic>> flats = [
    {'flatNo': 'Flat 101', 'usage': 120, 'residentName': 'John Doe', 'role': 'Owner'},
    {'flatNo': 'Flat 102', 'usage': 150, 'residentName': 'Jane Smith', 'role': 'Tenant'},
    {'flatNo': 'Flat 103', 'usage': 110, 'residentName': 'Alice Johnson', 'role': 'Owner'},
    {'flatNo': 'Flat 104', 'usage': 130, 'residentName': 'Bob Brown', 'role': 'Tenant'},
    {'flatNo': 'Flat 105', 'usage': 140, 'residentName': 'Charlie Davis', 'role': 'Owner'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meter Details for $meterId'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)], // Gradient colors
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: flats.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            flats[index]['flatNo'],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Resident: ${flats[index]['residentName']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Role: ${flats[index]['role']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Usage this month: ${flats[index]['usage']} units',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Implement history button functionality here
                                },
                                child: Text('History'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement edit button functionality here
                                },
                                child: Text('Edit'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement delete meter functionality here
              },
              child: Text('Delete Meter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Meter Details App',
    home: MeterDetailsPage(meterId: 'Meter 1'),
  ));
}
