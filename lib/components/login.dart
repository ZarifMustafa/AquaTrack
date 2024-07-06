import 'package:flutter/material.dart';
import 'package:water_flow_app/components/admin.dart';
import 'package:water_flow_app/components/owner.dart';
import 'package:water_flow_app/components/tenant.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(),
      backgroundColor: Colors.blue, // Set background color to blue
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  String? _errorMessage;

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
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
              obscureText: true,
              // validator: (value) {
              //   if (value!.isEmpty || value.length < 6) {
              //     return 'Password must be at least 6 characters long';
              //   }
              //   return null;
              // },
              onSaved: (value) {
                _password = value!;
              },
            ),
            SizedBox(height: 12.0),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _authenticateUser(context);
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _authenticateUser(BuildContext context) {
    if (_email == 'admin@gmail.com' && _password == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminPage()),
      );
    } else if (_email == 'owner@gmail.com' && _password == 'owner') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OwnerPage(
          ownerName: 'Owner Name', // Replace with actual owner name
          todayUsage: 150.0, // Replace with actual today's usage
          monthUsage: 4500.0, // Replace with actual month's usage
        )),
      );
    } else if (_email == 'tenant@gmail.com' && _password == 'tenant') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TenantPage(
          tenantName: 'Tenant Name', // Replace with actual tenant name
          todayUsage: 100.0, // Replace with actual today's usage
          monthUsage: 3000.0, // Replace with actual month's usage
        )),
      );
    } else {
      setState(() {
        _errorMessage = 'Incorrect email or password';
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Login App',
    home: LoginPage(),
  ));
}
