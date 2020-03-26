import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'uitility/ui_utility/MyTheme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Note',
      theme: MyTheme.getLightTheme(),
      darkTheme: MyTheme.getDarkTheme(),
      home: MyHome(),
    );
  }



}
