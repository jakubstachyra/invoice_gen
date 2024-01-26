import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:invoice_gen/components/buttons/discard_text.dart';
import 'package:invoice_gen/components/buttons/my_form_button.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_textfield.dart';
import 'package:invoice_gen/components/validators/not_empty_validator.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {super.key,
       required this.placeController,
       required this.issuanceController,
       required this.dateOfSaleController,
       required this.dateOfPaymentController,
       required this.idController
       });

  final TextEditingController placeController;
  final TextEditingController issuanceController;
  final TextEditingController dateOfSaleController;
  final TextEditingController dateOfPaymentController;
  final TextEditingController idController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 115,
        color: Colors.white,
        child:  Column(
          children: [
                MyButton(text: "  Summary  ",
                 callback: () {
                      context.read<InvoiceBloc>().add(UpdateInvoiceDetailsEvent(
                          invoiceID: idController.text,
                          date: DateTime.parse(dateOfPaymentController.text),
                          place: placeController.text,
                          issuance: issuanceController.text,
                          due: DateTime.parse(dateOfPaymentController.text)
                        ));
                      context.read<InvoiceBloc>().add(NavigateToSummaryPageEvent());
                    }),  
                const SizedBox(height: 10),
                const DiscardButton(),
          ])
              
      ),
        appBar: MyAppBar(text: const Text("Details"),
        callback: ()
        {
          BlocProvider.of<InvoiceBloc>(context).add(NavigateToProductsPageEvent());
        },),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [

                SizedBox(height: 65,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Text("Final Step!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,)),
                
                const SizedBox(height: 40),

                SizedBox(
                    child: MyTextField(
                        controller: idController,
                        hintText: "Invoice number",
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: MyTextFieldValidators.notEmptyValidator ,)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: placeController,
                        hintText: "Place",
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: MyTextFieldValidators.notEmptyValidator ,)),
                const SizedBox(height: 20),
                SizedBox(
                    child: MyTextField(
                        controller: issuanceController,
                        hintText: "Issunace",
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: MyTextFieldValidators.notEmptyValidator)),
                const SizedBox(height: 20),
                SizedBox(
                     child: MyFormButton(icon: const  Icon(Icons.calendar_month_outlined, color: Colors.black,),
                     text: " Pick date",
                     callback: () async  {final DateTime? picked = await showDatePicker(context: context,     firstDate: DateTime(2000), lastDate: DateTime(2025));
                            if (picked != null && picked != DateTime.now()) {
                            dateOfSaleController.text = picked.toIso8601String(); 
                         } }) ),
                const SizedBox(height: 20),
                SizedBox(
                     child: MyFormButton(icon: const  Icon(Icons.calendar_month, color: Colors.black,),
                     text: " Pick due",
                     callback: () async  {final DateTime? picked = await showDatePicker(context: context,     firstDate: DateTime(2000), lastDate: DateTime(2025));
                            if (picked != null && picked != DateTime.now()) {
                            dateOfPaymentController.text = picked.toIso8601String(); 
                         } }) ),
              ],
            )));
  }
}
