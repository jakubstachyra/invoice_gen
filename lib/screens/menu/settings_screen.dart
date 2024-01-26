import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:invoice_gen/blocs/invoice_color/bloc/invoice_color_bloc.dart';
import 'package:invoice_gen/blocs/invoice_color/functions_color.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:pdf/pdf.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String colorName = 'Blue'; // Domyślna wartość

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Settings Page Content'),
            MyButton(
              text: colorName,
              callback: () async {
                var currentColor = await InvoiceColorPreferences.getDefaultInvoiceColor();
                if (currentColor == PdfColors.blue) {
                  context.read<InvoiceColorBloc>().add(InvoiceColorChangeEvent(PdfColors.grey));
                  setState(() {
                    colorName = "Grey";
                  });
                } else {
                  context.read<InvoiceColorBloc>().add(InvoiceColorChangeEvent(PdfColors.blue));
                  setState(() {
                    colorName = "Blue";
                  });
                }
              },
            ),
            MyButton(
              text: "Log out",
              callback: () {
                context.read<AuthenticationBloc>().userRepository.logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}


