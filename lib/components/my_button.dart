import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({super.key});

  @override
  Widget build(BuildContext contex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity,
              50), // double.infinity is the width and 50 is the height
        ),
        onPressed: () {},
        child: const Text('Log in'),
      ),
    );
  }
}
