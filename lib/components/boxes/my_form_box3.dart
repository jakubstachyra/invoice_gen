import 'package:flutter/material.dart';

class MyFormBox3 extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  const MyFormBox3({super.key,
   required this.text,
   required this.text2,
   required this.text3});


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
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            child:
          Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ))),
            Text(
            text2,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
            Text(
            text3,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            
          ),
        ],
      ),
    ),
  ));
}}
