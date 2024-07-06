import 'package:flutter/material.dart';
import 'package:water_flow_app/components/register.dart';
import 'package:water_flow_app/components/login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 50, // Adjust this value to move the image downwards
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/shutterstock_139888759 1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust this value to move the text upwards
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Welcome to AquaTrack',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 400, // Adjust this value to position the quote
            left: 20,
            right: 20,
            child: Center(
              child: Text(
                '"Use water wisely and preserve it for future generations."',
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center, // Correctly place textAlign here
              ),
            ),
          ),
          Positioned(
            bottom: 80, // Adjust this value to move the buttons downwards
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to RegisterPage (register.dart)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {  
                    // Navigate to Sign In page or any other action
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
