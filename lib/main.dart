import 'package:farm_box/data_viewer.dart';
import 'package:farm_box/splash_screen.dart';
import 'package:flutter/material.dart';

import 'farmbox_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Box',
      theme: ThemeData(
        primaryColorLight: Colors.teal[300],
        primaryColor: Colors.teal,
        primaryColorDark: Colors.teal[800]
      ),
      home: SplashScreenView(),
      routes: <String, WidgetBuilder>{
        '/DataViewer' : (BuildContext context) => new DataViewer(),
        '/FarmboxHome' : (BuildContext context) => new FarmboxHome()
      },
    );
  }
}