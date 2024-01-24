import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_text.dart';
import 'package:invoice_gen/pdfAPI/pdf_api.dart';
import 'package:invoice_gen/pdfAPI/pdf_invoice_api.dart';
import 'package:invoice_gen/screens/invoice/invoice_generation.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen( {super.key,
  required this.invoice});
  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: MyAppBar(text: const Text("Invoice view"),
        callback: (){
             context.read<InvoiceBloc>().add(InitInvoiceEvent());
            Navigator.pop(context);
        }),
        body: SafeArea(
          child: SizedBox(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    const MyTextGrey(text: "Invoice Date"),
                    Text(Utils.formatDate(invoice.details.dateOfSale)),
                    const MyTextGrey(text: "Client"),
                    Text(invoice.customer.name),
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
                child:Column(

                  children: [
                Image.asset('assets/images/logo.png'),
                Text("Tap for preview", style: TextStyle(fontSize: 12,
                 color: Colors.blue[900],
                fontWeight: FontWeight.bold))
              ],))
              ]),

              const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "BILL TO")])),


              const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "ITEMS")])),
              const SizedBox(height: 80),
              Center(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children:[ 
                GestureDetector(
                  child: const  Icon(Icons.delete_forever, color: Colors.red),
                  onTap: () => {
                      PdfApi.deleteResourceFromFirestore(invoice.id),
                      Navigator.pop(context)
                }),
                GestureDetector(
                  child: const  Icon(Icons.edit, color: Colors.grey),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InvoiceGenerationScreen())),
                      context.read<InvoiceBloc>().add(
                      EditInvoiceEvent(invoice.seller,invoice.customer,invoice.items, invoice.details, invoice.id)),
                      
                }),  
                GestureDetector(
                  child: const  Icon(Icons.file_download_outlined, color: Colors.grey),
                  onTap: () async {
                    final file = await PdfInvoiceApi.generate(invoice);
                  }), 
                GestureDetector(
                  child: const  Icon(Icons.email, color: Colors.grey),
                  onTap: () => {
                }), 
                GestureDetector(
                  child: const  Icon(Icons.print, color: Colors.grey),
                  onTap: () => {
                }),   
                ])),
              ])
              ]),
            ))));
  }
}
