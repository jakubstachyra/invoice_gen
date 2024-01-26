import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';
import 'package:invoice_gen/components/my_texts/my_textfield.dart';


class AddCustomerScreen extends StatelessWidget {
  AddCustomerScreen({super.key});

  final nameController = TextEditingController();
  final tinController = TextEditingController();
  final addressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(text: const Text("Add Client"),
        callback: ()
        {
          BlocProvider.of<InvoiceBloc>(context).add(NavigateToCustomerPageEvent());
          Navigator.pop(context);
        }),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(height: 20,
                width: MediaQuery.of(context).size.width * 0.9,
                child: const MyTextGrey(text: "BILL TO")),
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
                MyButton(text: "Add Client",
                 callback: ()
                 {
                   context.read<InvoiceBloc>().add(UpdateCustomerEvent(
                          name: nameController.text,
                          address: addressController.text,
                          tin: tinController.text,
                        ));
                   context.read<InvoiceBloc>().add(AddCustomerToFireBaseEvent(nameController.text, tinController.text, addressController.text));  
                   BlocProvider.of<InvoiceBloc>(context).add(NavigateToCustomerPageEvent());
                   Navigator.pop(context);
                 })
              ],
            )));
  }
}
