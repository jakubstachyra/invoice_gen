import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/boxes/my_form_box.dart';
import 'package:invoice_gen/components/buttons/discard_text.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key, required this.userCustomers});
  final List<Company> userCustomers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar: MyAppBar(text: const Text("Customers"),
        callback:() {
                BlocProvider.of<InvoiceBloc>(context).add(NavigateToCustomerPageEvent());
              }),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                SizedBox(height: 65,
                width: MediaQuery.of(context).size.width,
                child: const Text("Who are you billing to?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,)),

                SizedBox(height: 20,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const MyTextGrey(text: "Customers")),
                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                      itemCount: userCustomers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: MyFormBox(text: userCustomers[index].name),
                        onTap: () => {
                          BlocProvider.of<InvoiceBloc>(context).add(UpdateCustomerEvent(name: userCustomers[index].name,
                        address: userCustomers[index].address,
                        tin: userCustomers[index].tin,)),
                        BlocProvider.of<InvoiceBloc>(context).add(NavigateToCustomerPageEvent())});
                        }
                )),  
                const DiscardButton()
              ]
            )));
  }
}
