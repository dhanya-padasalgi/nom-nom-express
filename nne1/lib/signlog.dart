import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool isLoginSelected = true;

  // Local variables to store user input during signup
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void toggleSelection() {
    setState(() {
      isLoginSelected = !isLoginSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final onPrimaryColor = theme.colorScheme.onPrimary;
    final secondaryColor = theme.colorScheme.secondary;
    final onSecondaryColor = theme.colorScheme.onSecondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(isLoginSelected ? 'Login' : 'Signup'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 100,
              left: 30,
              right: 30,
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 175,
                      decoration: BoxDecoration(
                        color: isLoginSelected ? primaryColor : secondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: toggleSelection,
                        child: Text('Login', style: TextStyle(color: onPrimaryColor)),
                      ),
                    ),
                    Container(
                      width: 175,
                      decoration: BoxDecoration(
                        color: isLoginSelected ? secondaryColor : primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: toggleSelection,
                        child: Text('Sign up', style: TextStyle(color: onPrimaryColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 30,
              right: 30,
              child: Column(
                children: [
                  if (isLoginSelected) ...[
                    _buildTextField('Email', secondaryColor),
                    _buildTextField('Password', secondaryColor),
                    ElevatedButton(
                      onPressed: () {
                        // Implement login logic here
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: Text('Login', style: TextStyle(color: onPrimaryColor)),
                    ),
                  ] else ...[
                    _buildTextField('Username', secondaryColor),
                    _buildTextField('Email', secondaryColor),
                    _buildTextField('Password', secondaryColor),
                    _buildTextField('Confirm Password', secondaryColor),
                    ElevatedButton(
                      onPressed: () {
                        // Implement signup logic here
                        if (validateSignUpInput()) {
                          // If input is valid, prepare the JSON payload
                          final Map<String, String> signUpData = {
                            'username': usernameController.text,
                            'email': emailController.text,
                            'password': passwordController.text,
                          };
                          final jsonData = json.encode(signUpData);

                          // Send the HTTP request
                          sendRequest(jsonData);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      child: Text('Create Account', style: TextStyle(color: onPrimaryColor)),
                    ),
                  ],
                  TextButton(
                    onPressed: toggleSelection,
                    child: Text(
                      isLoginSelected ? 'Switch to Signup' : 'Switch to Login',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, Color backgroundColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: TextEditingController(),
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  bool validateSignUpInput() {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      return false;
    }
    return true;
  }
}

Future<void> sendRequest(String jsonData) async {
  final url = Uri.parse('http://localhost:8000/your-api-endpoint');

  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: jsonData,
    );

    if (response.statusCode == 200) {
      print('Request successful');
      print('Response: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}