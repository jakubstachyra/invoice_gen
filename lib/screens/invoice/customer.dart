import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:invoice_gen/components/buttons/my_form_button.dart';
import 'package:invoice_gen/components/buttons/discard_text.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';
import 'package:invoice_gen/screens/invoice/add_customer.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key,
  required this.nameController,
  required this.tinController,
  required this.addressController});

  final TextEditingController nameController;
  final TextEditingController tinController;
  final TextEditingController addressController;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
        height: 115,
        color: Colors.white,
        child:  Column(
          children: [
                      MyButton(text: "Continue",
                 callback: () {
                      BlocProvider.of<InvoiceBloc>(context).add(UpdateCustomerEvent(
                        name: nameController.text, 
                        address: addressController.text, 
                        tin: tinController.text,
                        ));
                      BlocProvider.of<InvoiceBloc>(context).add(NavigateToProductsPageEvent());
                    }),
                const SizedBox(height: 10),
                const DiscardButton()
          ])),
        appBar: MyAppBar(text: const Text("Customer"),
        callback:() {
                BlocProvider.of<InvoiceBloc>(context).add(NavigateToSellerPageEvent());
              }),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),

                SizedBox(height: 65,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text("Who are you billing to?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,)),
                
                const SizedBox(height: 40),

                SizedBox(height: 20,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const MyTextGrey(text: "BILL TO")),
                
                const SizedBox(height: 5),

                MyFormButton(text: " Add Client",
                  icon: Icon(Icons.add_box, color: Colors.blue[900]),
                  callback:()  {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCustomerScreen(),
                      ),
                    );
                }),

                const SizedBox(height: 40),        
                SizedBox(height: 20,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const MyTextGrey(text: "RECENTLY USED")),
                const SizedBox(height: 5),

                 MyFormButton(text: "See all clients",
                  icon: Icon(Icons.arrow_right,
                   color: Colors.blue[900],),
                  callback:() {
                    BlocProvider.of<InvoiceBloc>(context).add(DownloadCustomersEvent());
                }),
                
                const SizedBox(height: 40,),
              ],
            )), );
  }
}
