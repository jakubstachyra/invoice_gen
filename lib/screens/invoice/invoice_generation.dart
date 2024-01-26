import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/screens/invoice/customer.dart';
import 'package:invoice_gen/screens/invoice/customers.dart';
import 'package:invoice_gen/screens/invoice/details.dart';
import 'package:invoice_gen/screens/invoice/items.dart';
import 'package:invoice_gen/screens/invoice/seller.dart';
import 'package:invoice_gen/screens/invoice/summary.dart';


class InvoiceGenerationScreen extends StatelessWidget {
  const InvoiceGenerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return BlocListener<InvoiceBloc, InvoiceState>(
  listener: (context, state) {
    if (state is InvoiceCompleted || state is InvoiceCancelled) {
      Navigator.pop(context);
    }
  },
  child: BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceInitial) {
          return SellerScreen(
            nameController: TextEditingController(),
            tinController: TextEditingController(),
            addressController: TextEditingController(),
          );

        }else if (state is SellerPageState) {
          final sellerData = state.seller;
          return SellerScreen(
          nameController: TextEditingController(text: sellerData.name),
          tinController: TextEditingController(text: sellerData.tin),
          addressController: TextEditingController(text: sellerData.address),
        );
      } 
        else if (state is CustomerPageState) {
          final sellerData = state.customer;
          return CustomerScreen(
          nameController: TextEditingController(text: sellerData.name),
          tinController: TextEditingController(text: sellerData.tin),
          addressController: TextEditingController(text: sellerData.address),
        );}
           else if (state is CustomersPageState) {
          return CustomersScreen(userCustomers: state.customers);
          } 
          else if (state is InvoiceProductsPageState) {
          return ItemsScreen();
        }
        else if(state is InvoiceDetailsPageState){
          final detailsData = state.details;
          return DetailsScreen(
            placeController: TextEditingController(text:detailsData.place),
            issuanceController: TextEditingController(text: detailsData.issuance),
            dateOfSaleController: TextEditingController(text: detailsData.dateOfSale.toIso8601String()),
            dateOfPaymentController: TextEditingController(text: detailsData.dateOfPayment.toIso8601String()),
            idController: TextEditingController(text: detailsData.id),
          );
        } else if (state is SummaryPageState) {
           return SummaryScreen(
            customer: state.customer,
            seller: state.seller,
            items: state.products,
            details: state.details,
           );}

        return const CircularProgressIndicator();
      },
    ));
  }
}

