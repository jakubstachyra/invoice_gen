import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';

class DiscardButton extends StatelessWidget {
  const DiscardButton({super.key});


@override
Widget build(BuildContext context) {
return GestureDetector(
                  child: Text("Discard", style: TextStyle(color: Colors.blue[900]),),
                  onTap: () => context.read<InvoiceBloc>().add(InvoiceCancelledEvent())
                );

}
}