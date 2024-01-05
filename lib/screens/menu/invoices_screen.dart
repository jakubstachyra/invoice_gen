import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_menagment/invoice_menagment_bloc.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Open'),
            Tab(text: 'Paid'),
            Tab(text: 'Overdue'),
          ],
        ),
      ),
      body: Center(
        child: BlocBuilder<InvoiceMenagmentBloc, InvoiceMenagmentState>(
            builder: (context, state) {
          if (state is InvoiceMenagmentInitial) {
            return const CircularProgressIndicator(color: Colors.blue);
          }
          if (state is InvoiceMenagmentLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${state.invoices.length}',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      for (int index = 0;
                          index < state.invoices.length;
                          index++)
                        Positioned(
                            left: 20.toDouble(),
                            top: (100 + 150 * index).toDouble(),
                            child: SizedBox(
                              height: 150,
                              width: 200,
                              child: state.invoices[index].image,
                            ))
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Text("Something went wrong!");
          }
        }),
      ),
    );
  }
}
