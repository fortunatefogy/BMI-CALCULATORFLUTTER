// ignore_for_file: prefer_const_constructors

import 'package:bmi/bmiregistration.dart';
import 'package:bmi/loginpage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange, // Set the background color to orange
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "asset/b.png",
                height: 200,
              ),
              Text(
                'Welcome to BMI Calculator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: Text(
                  'Discover your ideal health with the BMI Calculator app! Easily track and manage your body mass index for a healthier YOU',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
              ),
              SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Loginn()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Bmiregistration()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    child: Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
