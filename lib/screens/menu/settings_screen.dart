import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:invoice_gen/components/my_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(
      child: Column(
        children: [
          const Text('Settings Page Content'),
          MyButton(text: "Log out", callback: ()
          {
              context.read<AuthenticationBloc>().userRepository.logOut();
          })
        ],
      )
      ),
    );
  }
}
