import 'package:flutter/material.dart';

class MytextBlock extends StatelessWidget {
  final String text;
  final double height;

  const MytextBlock({super.key,
   required this.text,
   required this.height});


@override
Widget build(BuildContext context) {
return SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: height,
          child:  Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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