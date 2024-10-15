// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'loginpage.dart'; // Make sure these files exist in your project
import 'shared_prefs.dart';
// import 'onbording.dart';

// Define the SampleItem enum
enum SampleItem { itemOne }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[900],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _result = '';
  String _username = 'User'; // Default username

  SampleItem? selectedItem; // Declare the selectedItem variable

  double get radius => 20;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final username = await SharedPrefs.getUsername();
    setState(() {
      _username = username ?? 'User';
    });
  }

  void _calculateBMI() {
    final double heightCm = double.tryParse(_heightController.text) ?? 0;
    final double weightKg = double.tryParse(_weightController.text) ?? 0;

    if (heightCm > 0 && weightKg > 0) {
      final double heightM = heightCm / 100; // Convert height to meters
      final double bmi = weightKg / (heightM * heightM);

      String category;
      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi < 24.9) {
        category = 'Normal weight';
      } else if (bmi < 29.9) {
        category = 'Overweight';
      } else {
        category = 'Obesity';
      }

      setState(() {
        _result = 'Your BMI is ${bmi.toStringAsFixed(2)}\n$category';
      });
    } else {
      setState(() {
        _result = 'Please enter valid height and weight';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("      BMI Calculator",style: TextStyle(color: Colors.white),)), // Use _username here
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange.shade800, Colors.orange.shade400],
                ),
              ),
              child: Text(
                '$_username', // Use _username here
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                // Clear the login status
                await SharedPrefs.setLoggedIn(false);

                // Navigate back to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loginn()),
                );
              },
            ),
          ],
        ),
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Hello, $_username !',
                  style: TextStyle(color: Colors.white, fontSize: 40),
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
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _heightController,
                          hintText: 'Height (cm)',
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          controller: _weightController,
                          hintText: 'Weight (kg)',
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          onPressed: _calculateBMI,
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Calculate',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          _result,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
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
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
