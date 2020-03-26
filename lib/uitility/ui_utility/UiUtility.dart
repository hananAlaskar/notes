import 'package:flutter/material.dart';

class UiUtility{


  static void showAlertDialog(String title, String message, BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}