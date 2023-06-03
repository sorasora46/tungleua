import 'package:flutter/material.dart';

final roundedOutlineButton = ButtonStyle(
  foregroundColor: const MaterialStatePropertyAll(Colors.green),
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
);

const filledButton =
    ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green));
