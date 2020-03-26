import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class ImageUtility {


  static Future<String> getImageFromPreferences(String imageKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(imageKey) ?? null;
  }

  static void saveImageToPreferences(String imageKey,String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(imageKey, value);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}