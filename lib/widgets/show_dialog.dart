import 'package:flutter/material.dart';

class SnackBarVariant {
  static String error = 'error';
  static String success = 'success';
}

/// variant: 'error' | 'success'
void showCustomSnackBar(BuildContext context, String message, String variant) {
  Color color = Colors.lightBlue;
  if (variant == SnackBarVariant.error) {
    color = Colors.red;
  }

  if (variant == SnackBarVariant.success) {
    color = Colors.green;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: color,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        padding: const EdgeInsets.all(4),
        content: Text(message, style: const TextStyle(fontSize: 16))),
  );
}
