import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/boxes/my_form_box.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:invoice_gen/components/buttons/discard_text.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';
import 'package:invoice_gen/screens/invoice/add_item.dart';

class ItemsScreen extends StatelessWidget {
  ItemsScreen({super.key});

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final vatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late List<Item> items =  BlocProvider.of<InvoiceBloc>(context).items;
    return Scaffold(
        appBar: MyAppBar(text: const Text("Products"),
        callback:() {
                BlocProvider.of<InvoiceBloc>(context).add(NavigateToCustomerPageEvent());
              }),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(height: 65,
                width: MediaQuery.of(context).size.width,
                child: const Text("What did you sell?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,)),

                SizedBox(height: 20,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const MyTextGrey(text: "ITEMS")),
                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: MyFormBox(text: items[index].name));
                      }),
                ),
                MyButton(text: "Add item",
                 callback:() async {
                      final newItem = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemScreen(),
                        ),
                      );
                      if (newItem != null) {
                        items = List.from(items)..add(newItem);
                      }
                    }),
                const SizedBox(height: 20),
                MyButton(text: "Continue",
                 callback: (){
                      BlocProvider.of<InvoiceBloc>(context).add(NavigateToDetailsPageEvent());
                    }),
                const SizedBox(height: 20),    
                const DiscardButton()
              ]
            )));
  }
}
