// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:bmi/loginpage.dart'; // Ensure this import is correct for your project
import 'shared_prefs.dart';

class Bmiregistration extends StatefulWidget {
  const Bmiregistration({super.key});

  @override
  _BmiregistrationState createState() => _BmiregistrationState();
}

class _BmiregistrationState extends State<Bmiregistration> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _submit() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (username.isNotEmpty &&
        password.isNotEmpty &&
        password == confirmPassword) {
      SharedPrefs.saveUsername(username);
      SharedPrefs.savePassword(password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: const Text('Registration Successfull!')),
            backgroundColor: Colors.orange[900],
            duration: const Duration(milliseconds: 1500),
            width: 250.0, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );      
              Future.delayed(Duration(milliseconds: 400), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Loginn()),
          );
      });
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.orange.shade900), // Title color
          ),
          content: Text(
            'Fill all fields correctly',
            style: TextStyle(color: Colors.grey.shade800), // Content color
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                'OK',
                style: TextStyle(
                    color: Colors.orange.shade900), // Button text color
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10, // Shadow effect
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Register",
                        style: TextStyle(color: Colors.white, fontSize: 40)),
                    SizedBox(height: 10),
                    Text("Welcome",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200)),
                              ),
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200)),
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200)),
                              ),
                              child: TextField(
                                controller: _confirmPasswordController,
                                obscureText: !_isConfirmPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isConfirmPasswordVisible =
                                            !_isConfirmPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      MaterialButton(
                        onPressed: _submit,
                        height: 50,
                        color: Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text("Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
