import 'package:flutter/material.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/my_textfield.dart';
import 'package:invoice_gen/screens/invoice/customer.dart';

class SellerScreen extends StatelessWidget {
  SellerScreen({super.key});
  final nameController = TextEditingController();
  final tinController = TextEditingController();
  final addressController = TextEditingController();
  late Company seller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Seller"),
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
                        hintText: "Name",
                        obscureText: false,
                        keyboardType: TextInputType.name)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: tinController,
                        hintText: "Tin",
                        obscureText: false,
                        keyboardType: TextInputType.number)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: addressController,
                        hintText: "Adress",
                        obscureText: false,
                        keyboardType: TextInputType.number)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      seller = Company(
                          nameController.toString(),
                          addressController.toString(),
                          tinController.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                CustomerScreen(seller: seller)),
                      );
                    },
                    style: TextButton.styleFrom(
                        elevation: 50,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Continue',
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
