// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:bmi/bmiregistration.dart';
import 'package:bmi/home.dart';
import 'shared_prefs.dart'; // Make sure this import points to the correct path of your SharedPrefs file

class Loginn extends StatefulWidget {
  @override
  State<Loginn> createState() => _LoginState();
}

class _LoginState extends State<Loginn> {
  bool _obscureText = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final username = await SharedPrefs.getUsername();
    final password = await SharedPrefs.getPassword();

    if (username != null && password != null) {
      _usernameController.text = username;
      _passwordController.text = password;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _submit() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      final savedUsername = await SharedPrefs.getUsername();
      final savedPassword = await SharedPrefs.getPassword();

      if (username == savedUsername && password == savedPassword) {
        // Save login status
        await SharedPrefs.setLoggedIn(true);

        // Show a SnackBar saying "Logged in"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: const Text('Logging in Please Wait!')),
            backgroundColor: Colors.orange[900],
            duration: const Duration(milliseconds: 800),
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

        // Navigate to the BmiCalculator after successful validation
        Future.delayed(Duration(milliseconds: 850), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BmiCalculator()),
          );
      });
      } else {
        // Show a message if credentials are incorrect
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.orange.shade900), // Title color
            ),
            content: Text(
              'Invalid Credentials',
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
    } else {
      // Show a message if username or password is empty
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.orange.shade900), // Title color
          ),
          content: Text(
            'Fill all fields',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login",
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                  SizedBox(height: 10),
                  Text("Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
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
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: _togglePasswordVisibility,
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
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Bmiregistration(),
                            ),
                          );
                        },
                        child: Text(
                          "New user?",
                          style: TextStyle(
                            color: Colors.orange[900],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
