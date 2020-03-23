import 'package:flutter/material.dart';

import 'pages/HomePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note',
      theme: getThemeData(),
      home: MyHome(),

    );
  }

  getThemeData(){

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],
      buttonColor: Colors.lightBlue[600],
      textSelectionColor: Colors.lightBlue[200],
      cardColor: Colors.lightBlue[50],

      fontFamily: 'Georgia',

      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );

  }
}


