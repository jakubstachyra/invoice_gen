import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:invoice_gen/blocs/invoice_color/bloc/invoice_color_bloc.dart';
import 'package:invoice_gen/blocs/invoice_color/functions_color.dart';
import 'package:invoice_gen/components/buttons/my_form_button.dart';
import 'package:pdf/pdf.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String colorName = 'Change invoice color'; // Domyślna wartość
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding (padding: const EdgeInsets.symmetric(horizontal: 15) ,child:
        Column(
          children: [
            const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
            const SizedBox(height: 50),
            MyFormButton(
              icon: const Icon(Icons.color_lens_outlined, color: Colors.black,),
              text: colorName,
              callback: () async {
                var currentColor = await InvoiceColorPreferences.getDefaultInvoiceColor();
                if (currentColor == PdfColors.blue)  {
                  // ignore: use_build_context_synchronously
                  context.read<InvoiceColorBloc>().add(const InvoiceColorChangeEvent(PdfColors.grey));
                  setState(() {
                    colorName = "Grey";
                  });
                } else {
                  // ignore: use_build_context_synchronously
                  context.read<InvoiceColorBloc>().add(const InvoiceColorChangeEvent(PdfColors.blue));
                  setState(() {
                    colorName = "Blue";
                  });
                }
              },
            ),
            const SizedBox(height: 15),
            MyFormButton(
              icon: const Icon(Icons.logout_outlined, color: Colors.black,),
              text: "Log out",
              callback: () {
                context.read<AuthenticationBloc>().userRepository.logOut();
              },
            ),
          ],
        ),
      ),
    ));
  }
}


