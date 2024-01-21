import 'package:flutter/material.dart';

class MyFormBox extends StatelessWidget {
  final String text;
  const MyFormBox({super.key,
   required this.text});


@override
Widget build(BuildContext context) {
return GestureDetector(
  onTap: null,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  ),
);
}}
