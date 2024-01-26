import 'package:flutter/material.dart';

class MyTextGrey extends StatelessWidget {
  final String text;
  const MyTextGrey(
      {super.key,
      required this.text,});


@override
Widget build(BuildContext context) {
 return Text(text,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900]));
  }
}                 