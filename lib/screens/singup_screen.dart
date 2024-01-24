// import 'package:flutter/material.dart';
// import 'package:invoice_gen/components/my_textfield.dart';
// import 'package:invoice_gen/screens/login_screen.dart';

// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});

//   final emailController = TextEditingController();
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // Miejsce na twoje logo
//                 Image.asset('assets/images/logo.png', height: 100, width: 100),
//                 const SizedBox(height: 50),

//                 // Pole na email
//                 MyTextField(
//                     controller: emailController,
//                     hintText: "Email",
//                     obscureText: false),

//                 const SizedBox(height: 20),

//                 // Pole na username
//                 MyTextField(
//                     controller: usernameController,
//                     hintText: "Username",
//                     obscureText: false),

//                 const SizedBox(height: 20),
//                 // Pole na hasło
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Password',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Pole na potwierdzenie hasła
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Confirm Password',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // Przycisk Sign Up
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     onPressed: () {
//                       //event holder
//                     },
//                     child: const Text('Sign Up'),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Link do logowania
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text("Already have an account? "),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Log in'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
