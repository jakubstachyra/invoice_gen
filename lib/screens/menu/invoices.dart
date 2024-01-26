import 'package:flutter/material.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:invoice_gen/components/buttons/my_form_button.dart';
import 'package:invoice_gen/pdfAPI/pdf_api.dart';
import 'package:invoice_gen/screens/menu/invoice_menagment.dart';

class CombinedInvoicesScreen extends StatefulWidget {
  const CombinedInvoicesScreen({super.key});

  @override
  State<CombinedInvoicesScreen> createState() => _CombinedInvoicesScreenState();
}

class _CombinedInvoicesScreenState extends State<CombinedInvoicesScreen> {
  late Future<List<Invoice>> invoicesFuture;

  @override
  void initState() {
    super.initState();
    invoicesFuture = PdfApi.downloadData();
  }

  Future<void> refreshInvoices() async {
    setState(() {
      invoicesFuture = PdfApi.downloadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const  Center(child: Text('List of Invoices')), // Zmiana tytułu AppBar
      ),
      body: RefreshIndicator(
        child: FutureBuilder<List<Invoice>>(
          future: invoicesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("You have no invoices yet"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var invoiceData = snapshot.data![index];
                  return ListTile(
                    title: MyFormButton(text: " Invoice: ${invoiceData.details.id} ${Utils.formatDate(invoiceData.details.dateOfSale)}",
                     icon: const Icon(Icons.edit_document,color: Colors.grey ),
                    callback: () async {
                          refreshInvoices();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoiceScreen(invoice: invoiceData)),
                      );
                    },)

                  );
                },
              );
            } else {
              return const Text("You have no invoices yet");
            }
          },
        ),
        onRefresh: () => refreshInvoices(),
      ),
    );
  }
}

