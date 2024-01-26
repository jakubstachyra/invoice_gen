import 'package:flutter/material.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:invoice_gen/pdfAPI/pdf_api.dart';
import 'package:invoice_gen/screens/menu/invoice_menagment.dart';

class CombinedInvoicesScreen extends StatefulWidget {
  const CombinedInvoicesScreen({super.key});

  @override
  State<CombinedInvoicesScreen> createState() => _CombinedInvoicesScreenState();
}

class _CombinedInvoicesScreenState extends State<CombinedInvoicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Invoice>> invoicesFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
     invoicesFuture = PdfApi.downloadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        toolbarHeight: 10,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Open'),
            Tab(text: 'Paid'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInvoiceListTab(), // for 'All'
          _buildInvoiceListTab(), // for 'Open'
          _buildInvoiceListTab(), // for 'Paid'
        ],
      ),
    );
  }

  Widget _buildInvoiceListTab() {
    // Replace with actual data fetching logic for each tab
    return RefreshIndicator(
      child: FutureBuilder<List<Invoice>>(
        future: PdfApi.downloadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) { 
            return const Center(child: Text("You have no invoices yet"));
          }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var invoiceData = snapshot.data![index];
                return ListTile(
                  title: Text("Invoice: ${invoiceData.details.id} ${Utils.formatDate(invoiceData.details.dateOfSale)}"),
                  onTap: () async {
                      refreshInvoices();
                     await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoiceScreen(invoice: invoiceData)),
                      );

                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>  Divider(color: Theme.of(context).colorScheme.primary,
              endIndent: 10,indent: 10,),
            );
          } else {
            return const Text("You have no invoices yet");
          }
        },
      ),
      onRefresh: () => refreshInvoices(),
    );
  }
}
