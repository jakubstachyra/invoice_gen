import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_button.dart';
import 'package:invoice_gen/components/my_text.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen( {super.key,
  required this.seller,
  required this.customer,
  required this.items,
  required this.details});
  
  final Company seller;
  final Company customer;
  final List<Item> items;
  final Details details; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: MyAppBar(text: const Text("New Invoice"),
        callback: (){
            BlocProvider.of<InvoiceBloc>(context).add(NavigateToDetailsPageEvent());
        }),
        body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                children:[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
              [
              Row(
                children: [ Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    const MyTextGrey(text: "Invoice Date"),
                    Text(Utils.formatDate(details.dateOfSale)),
                    const MyTextGrey(text: "Client"),
                    Text(customer.name),
                    const MyTextGrey(text: "Total Amount"),
                  ]), 
              
              SizedBox(width: MediaQuery.of(context).size.width * 0.3),
              GestureDetector(
                onTap: (){
                  //  Navigator.push(
                  //     context,
                  //      MaterialPageRoute(builder: (context) => PdfPreviewScreen()),
                  // );
                },
                child:Column(children: [
                Image.asset('assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.2),
                Text("Tap for preview", style: TextStyle(fontSize: 12,
                 color: Colors.blue[900],
                fontWeight: FontWeight.bold))
              ],))
              ]),

              const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "BILL TO")])),

              Card(color: Colors.grey.shade200,
              child:
              ListTile(
                title: Text(customer.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[ 
                  Text(customer.address),
                  Text(customer.tin)],
)
              )),

              const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "ITEMS")])),
              Card(color: Colors.grey.shade200,
              child:
              ListTile(
                title: Text(customer.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[ 
                  Text(customer.address),
                  Text(customer.tin)],
)
              )),
               const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "Total")])),
              Card(color: Colors.grey.shade200,
              child:
              ListTile(
                title: Text(customer.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[ 
                  Text(customer.address),
                  Text(customer.tin)],
)
              )),
              const SizedBox(height: 30),
              Card(color: Colors.grey.shade200,
              child:
              ListTile(
                title: Text(customer.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[ 
                  Text(customer.address),
                  Text(customer.tin)],
)
              )),
              const SizedBox(height: 80),
              Center(
              child: MyButton(text: "Save Invoice",
                callback: () async{
                      context.read<InvoiceBloc>().add(CompleteInvoiceEvent());                
                  }))
              ])
              ]),
               
            ))));
  }
}
