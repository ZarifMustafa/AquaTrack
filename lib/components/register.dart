import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: RegisterForm(),
      backgroundColor: Colors.blue, // Set background color to blue
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _contactNo;
  late String _address;
  late String _password;
  late String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.blue.shade400, Color.fromARGB(255, 130, 186, 221)], // Gradient colors
        ),
      ),
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
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
                _email = value!;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact Number',
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
              onSaved: (value) {
                _contactNo = value!;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              onSaved: (value) {
                _address = value!;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty || value != _password) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) {
                _confirmPassword = value!;
              },
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Implement registration logic here, e.g., submit data to server
                  // For demonstration, print the values
                  print('Name: $_name');
                  print('Email: $_email');
                  print('Contact Number: $_contactNo');
                  print('Address: $_address');
                  print('Password: $_password');
                  print('Confirm Password: $_confirmPassword');
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Registration App',
    home: RegisterPage(),
  ));
}
