import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:invoice_gen/components/my_button.dart';
import 'package:invoice_gen/components/my_textfield.dart';
import './singup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 100, width: 100),
                const SizedBox(height: 100),

                // Pole na email/username
                MyTextField(
                  controller: usernameController,
                  labelText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // Pole na hasło
                MyTextField(
                    controller: passwordController,
                    labelText: "Password",
                    obscureText: true),
                const SizedBox(height: 10),

                // Checkbox 'Remember me' oraz 'Forgot password?'
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {
                          // Handle remember me checkbox
                        },
                      ),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Przycisk Log In
                MyButton(),
                const SizedBox(height: 20),
                // Link do rejestracji
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
