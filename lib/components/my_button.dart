import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  
  const MyButton({super.key,
   required this.text,
   required this.callback,});

@override
Widget build(BuildContext context) {
  return TextButton(
      onPressed: callback, 
    style: TextButton.styleFrom(
        elevation: 3.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60))),
    child:  Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    ));
  }
}