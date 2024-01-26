import 'package:flutter/material.dart';

class MyFormButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Icon icon;
  const MyFormButton({super.key,
   required this.text,
   required this.callback,
   required this.icon});


@override
Widget build(BuildContext context) {
return TextButton(  
          onPressed: callback,
          style: TextButton.styleFrom(
              elevation: 3.0,
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child:  Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              icon,
              Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18),
            )],
      )
    ));
  }
}