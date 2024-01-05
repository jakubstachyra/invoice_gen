import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/my_textfield.dart';
import 'package:invoice_gen/screens/invoice/add_item.dart';
import 'package:invoice_gen/screens/invoice/details.dart';

class ItemsScreen extends StatelessWidget {
  ItemsScreen({super.key, required this.seller, required this.customer});

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final vatController = TextEditingController();
  final Company seller;
  final Company customer;
  late List<Item> items = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("What did you sell?"),
          elevation: 0,
          toolbarHeight: 100,
          foregroundColor: Colors.blue[900],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 80,
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text(items[index].name));
                      }),
                ),
                TextButton(
                    onPressed: () async {
                      final newItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemScreen(),
                        ),
                      );
                      if (newItem != null) {
                        items = List.from(items)..add(newItem);
                      }
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
                    )),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () async {
                      final newItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              seller: seller, customer: customer, items: items),
                        ),
                      );
                      if (newItem != null) {
                        items = List.from(items)..add(newItem);
                      }
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
