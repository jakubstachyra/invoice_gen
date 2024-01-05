import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/my_textfield.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final taxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add item"),
          elevation: 0,
          toolbarHeight: 100,
          foregroundColor: Colors.blue[900],
        ),
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
                TextButton(
                    onPressed: () {
                      Item newitem = Item(double.parse(priceController.text),
                          nameController.text, int.parse(taxController.text));
                      Navigator.pop(context, newitem);
                    },
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Add item',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ))
              ],
            )));
  }
}
