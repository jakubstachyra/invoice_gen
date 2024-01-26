import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:invoice_gen/components/boxes/my_form_box2.dart';
import 'package:invoice_gen/components/boxes/my_form_box3.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';
import 'package:invoice_gen/pdfAPI/pdf_api.dart';
import 'package:invoice_gen/screens/invoice/invoice_generation.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key, required this.invoice});
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text:  Text(invoice.details.id),
        callback: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FittedBox(
                                  child:
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  width: MediaQuery.of(context).size.height * 0.2,
                                )),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                        child: Row(children: [MyTextGrey(text: "BILL TO")]),
                      ),
                      MyFormBox3(text: invoice.customer.name,text2: invoice.customer.address,text3: invoice.customer.tin),
                      Column(
                            children: [
                              const SizedBox(height: 30, child: Row(children: [MyTextGrey(text: "ITEMS")])),
                              ...invoice.items.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 1),
                                child: 
                                MyFormBox3(text: "Name: ${item.name}",text2: " Quantity: ${item.quantity.toString()}x",
                                 text3: "Per unit: ${item.price.toString()}\$")
                                
                              )).toList()]),
                    ]),                      
                      const SizedBox(
                        height: 30,
                        child: Row(children: [MyTextGrey(text: "DETAILS")]),
                      ), Column(
                        children:[
                      MyFormBox2(text: "Invoice Number: ", text2: invoice.details.id),
                      const SizedBox(height: 2),
                      MyFormBox2(text: "Invoice Date: ", text2: Utils.formatDate(invoice.details.dateOfSale)),
                      const SizedBox(height: 2),
                      MyFormBox2(text: "Payment date ", text2: Utils.formatDate(invoice.details.dateOfPayment))]),
                      const SizedBox(height: 10),
                      
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.delete_forever, color: Colors.red),
                    onTap: () => {
                      PdfApi.deleteResourceFromFirestore(invoice.id),
                      Navigator.pop(context)
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.edit, color: Colors.grey),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InvoiceGenerationScreen()),
                      ),
                      context.read<InvoiceBloc>().add(
                        EditInvoiceEvent(invoice.seller, invoice.customer, invoice.items, invoice.details, invoice.id),
                      ),
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.file_download_outlined, color: Colors.grey),
                    onTap: () async {
                      PdfApi.saveFile(context, invoice);
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.email, color: Colors.grey),
                    onTap: () => {
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.print, color: Colors.grey),
                    onTap: () => {
                      PdfApi.print(invoice)
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
