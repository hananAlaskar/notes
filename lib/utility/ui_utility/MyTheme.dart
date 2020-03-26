import 'package:flutter/material.dart';

class MyTheme{


  static getDarkTheme(){

    return  ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo[800],
        accentColor: Colors.indigo[300],
        buttonColor: Colors.indigo[800],
        cardColor: Colors.indigo[400],
        backgroundColor: Colors.indigo[400],

        fontFamily: 'Georgia',

        textTheme: TextTheme(
          subtitle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.indigo[50]),
          title: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic, color: Colors.indigo[50]),
          display1: TextStyle(fontSize: 24.0, height: 2.0, color: Colors.indigo[100]),
          display2: TextStyle(fontSize: 16.0, height: 1.5, color:Colors.indigo[100]),
          body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.indigo[100]),
          body2: TextStyle(fontSize: 12.0, fontFamily: 'Hind', color: Colors.indigo[50]),
          button: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.indigo[50]),

        )
    );

  }

  static getLightTheme(){

    return  ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.lightBlue[50],
      buttonColor: Colors.lightBlue[600],
      cardColor: Colors.lightBlue[100],

      fontFamily: 'Georgia',

      textTheme: TextTheme(
        subtitle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 24.0,fontStyle: FontStyle.italic),
        display1: TextStyle(fontSize: 24.0, height: 2.0, color: Colors.black),
        display2:TextStyle(fontSize: 16.0, height: 1.5, color: Colors.black),
        body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        body2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        button: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),

      ),


    );
  }


}