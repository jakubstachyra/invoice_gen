import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/components/buttons/discard_text.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_textfield.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final taxController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
         height: 115,
        color: Colors.white,
        child:  Column(
          children: [
                MyButton(text: "  Add item ",
                 callback: () {
                          context.read<InvoiceBloc>().add(AddProductEvent(
                          name: nameController.text,
                          price: double.parse(priceController.text),
                          tax: int.parse(taxController.text),
                          quantity: int.parse(quantityController.text)
                        ));
                    BlocProvider.of<InvoiceBloc>(context).add(NavigateToProductsPageEvent());
                    Navigator.pop(context);
                    }),  
                const SizedBox(height: 10),
                const DiscardButton(),
          ])
      ),
        appBar: MyAppBar(text: const Text("Add item"),
        callback: (){
          BlocProvider.of<InvoiceBloc>(context).add(NavigateToProductsPageEvent());
          Navigator.pop(context);
        }),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(
                    child: MyTextField(
                        controller: nameController,
                        hintText: "Item Name",
                        obscureText: false,
                        keyboardType: TextInputType.name)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: priceController,
                        hintText: "Price",
                        obscureText: false,
                        keyboardType: TextInputType.number)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: taxController,
                        hintText: "Tax",
                        obscureText: false,
                        keyboardType: TextInputType.number)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: quantityController,
                        hintText: "Quantity",
                        obscureText: false,
                        keyboardType: TextInputType.number))]
            )));
  }
}
