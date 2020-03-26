import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import 'utility/ui_utility/MyTheme.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.getLightTheme(),
      darkTheme: MyTheme.getDarkTheme(),
      home: MyHome(),
    );
  }



}
