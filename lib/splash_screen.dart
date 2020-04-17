import 'dart:async';
import 'package:flutter/material.dart';
class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.teal[50], Colors.pink[50]], begin: Alignment.topRight),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(40.00),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    splashTime();
  }

  splashTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, callback);
  }
  
  void callback() {
    Navigator.pushReplacementNamed(context, '/FarmboxHome');
  }
}
