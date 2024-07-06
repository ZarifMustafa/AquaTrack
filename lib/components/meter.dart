import 'package:flutter/material.dart';
import 'package:water_flow_app/components/addMeter.dart';
import 'meterDetails.dart'; // Import the meterDetails.dart file

class MeterPage extends StatefulWidget {
  @override
  _MeterPageState createState() => _MeterPageState();
}

class _MeterPageState extends State<MeterPage> {
  final List<Map<String, dynamic>> meters = [
    {'id': 'Meter 1'},
    {'id': 'Meter 2'},
    {'id': 'Meter 3'},
    {'id': 'Meter 4'},
    {'id': 'Meter 5'},
    {'id': 'Meter 6'},
    {'id': 'Meter 7'},
    {'id': 'Meter 8'},
    {'id': 'Meter 9'},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredMeters = meters
        .where((meter) => meter['id']
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Meters'),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search Meter',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMeterPage()),
                  );
                },
                child: Text('Add Meter'),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: filteredMeters.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MeterDetailsPage(meterId: filteredMeters[index]['id']),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5.0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            filteredMeters[index]['id'],
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Meter App',
    home: MeterPage(),
  ));
}
