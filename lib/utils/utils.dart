import 'package:firebase_authentication/main.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(String? text) {
    if (text == null) return;
    
    final SnackBar snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    scaffoldMessengerKey.currentState!
      ..removeCurrentSnackBar
      ..showSnackBar(snackBar);
  }
}
