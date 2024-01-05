import 'package:flutter/material.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/my_textfield.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen(
      {super.key,
      required this.seller,
      required this.customer,
      required this.items});

  final placeController = TextEditingController();
  final issuanceController = TextEditingController();
  final dateOfSaleController = TextEditingController();
  final dateOfPaymentController = TextEditingController();
  final idController = TextEditingController();
  final Company seller;
  final Company customer;
  final List<Item> items;
  late Details details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Details"),
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
                        controller: idController,
                        hintText: "Id of Invoice",
                        obscureText: false,
                        keyboardType: TextInputType.name)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: placeController,
                        hintText: "Place",
                        obscureText: false,
                        keyboardType: TextInputType.name)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: issuanceController,
                        hintText: "Issunace",
                        obscureText: false,
                        keyboardType: TextInputType.number)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: dateOfSaleController,
                        hintText: "Date of Sale",
                        obscureText: false,
                        keyboardType: TextInputType.datetime)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: dateOfPaymentController,
                        hintText: "Date of Payment",
                        obscureText: false,
                        keyboardType: TextInputType.datetime)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      details = Details(
                          placeController.text,
                          issuanceController.text,
                          dateOfSaleController.text,
                          dateOfPaymentController.text,
                          idController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => DetailsScreen(
                                  seller: seller,
                                  customer: customer,
                                  items: items,
                                )),
                      );
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
