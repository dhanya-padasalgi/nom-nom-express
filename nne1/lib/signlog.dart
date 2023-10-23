
import 'package:flutter/material.dart';



class LoginSignupPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isLoginSelected = true;

  void toggleSelection() {
    setState(() {
      isLoginSelected = !isLoginSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLoginSelected ? 'Login' : 'Signup'),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isLoginSelected ? Colors.yellow : Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoginSelected) ...[
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement login logic here
                  },
                  child: Text('Login'),
                ),
              ] else ...[
                TextField(
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement signup logic here
                  },
                  child: Text('Create Account'),
                ),
              ],
              TextButton(
                onPressed: toggleSelection,
                child: Text(isLoginSelected ? 'Switch to Signup' : 'Switch to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}