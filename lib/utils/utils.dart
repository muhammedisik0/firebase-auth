import 'package:firebase_authentication/main.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(String? text, [Color backgroundColor = Colors.red]) {
    if (text == null) return;

    final SnackBar snackBar = SnackBar(
      content: Text(text),
      backgroundColor: backgroundColor,
    );

    scaffoldMessengerKey.currentState!
      ..removeCurrentSnackBar
      ..showSnackBar(snackBar);
  }
}
