import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:invoice_gen/screens/auth/welcome_screen.dart';
import 'package:invoice_gen/screens/menu/main_screen.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'InvoiceGen',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(background: Colors.white),
        fontFamily: 'Mukta',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const[
        Locale('en'),
        Locale('es'),
        Locale('pl'),
      ] ,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(
                userRepository: context.read<AuthenticationBloc>().userRepository,
              ),
                child: const MainScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
