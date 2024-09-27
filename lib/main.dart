import 'package:firebase_core/firebase_core.dart';
import 'package:water_flow_app/components/addMeter.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:water_flow_app/components/graph.dart';
import 'package:water_flow_app/components/home.dart'; // Adjust package name accordingly

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Display HomePage (which is defined in lib/components/home.dart)
      debugShowCheckedModeBanner: false,
    );
  }
}
