// ignore_for_file: prefer_const_constructors

import 'package:bmi/home.dart';
import 'package:bmi/onbording.dart';
import 'package:bmi/shared_prefs.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Start the navigation check after 3 seconds
    Future.delayed(Duration(seconds: 3), () async {
      bool loggedIn = await SharedPrefs.isLoggedIn();
      if (loggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => BmiCalculator()));  // Navigate to HomePage if logged in
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => WelcomePage()));  // Navigate to LoginPage if not logged in
      }
    });

    return Scaffold(
      backgroundColor: Colors.orange,  // You can set any background color or image
      body: Center(
        child: Image.asset("asset/logod.png",height: 200,width: 200,)
      ),
    );
  }
}
