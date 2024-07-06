import 'package:flutter/material.dart';
import 'meter.dart'; // Import the meter.dart file

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)], // Gradient colors
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeterPage()),
              );
            },
            child: Text('Meters'),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Admin App',
    home: AdminPage(),
  ));
}
