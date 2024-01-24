import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/components/discard_text.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_button.dart';
import 'package:invoice_gen/components/my_textfield.dart';

class SellerScreen extends StatelessWidget {
  const SellerScreen({
    Key? key,
    required this.nameController,
    required this.tinController,
    required this.addressController,
  }) : super(key: key);
  
  final TextEditingController nameController;
  final TextEditingController tinController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          text: const Text("Seller"),
          callback: ()
          {
            BlocProvider.of<InvoiceBloc>(context).add(InvoiceCancelledEvent());
          },
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SafeArea(
            child:
            Column(
              children: [
                SizedBox(
                    child: MyTextField(
                        controller: nameController,
                        hintText: "Name",
                        obscureText: false,
                        keyboardType: TextInputType.text)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: tinController,
                        hintText: "Tin",
                        obscureText: false,
                        keyboardType: TextInputType.text)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: addressController,
                        hintText: "Adress",
                        obscureText: false,
                        keyboardType: TextInputType.text)),
                const SizedBox(height: 20),
                MyButton(text: "Continue",
                 callback: () {
                        BlocProvider.of<InvoiceBloc>(context).add(UpdateSellerEvent(
                        name: nameController.text, 
                        address: addressController.text, 
                        tin: tinController.text,
                        ));
                      BlocProvider.of<InvoiceBloc>(context).add(NavigateToCustomerPageEvent());
                 }
                ),
                const SizedBox(height: 20),
                const DiscardButton()
              ],
            ))));
  }
}
