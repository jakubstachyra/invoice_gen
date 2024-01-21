import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key, required this.callback});
  
  final VoidCallback callback;

@override
Widget build(BuildContext context) {
  return IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Użyj własnej ikony
          onPressed: callback,
        );
  }
}