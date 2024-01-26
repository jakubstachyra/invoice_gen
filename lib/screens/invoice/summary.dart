import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_gen/blocs/invoice_generation/invoice_bloc.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:invoice_gen/components/boxes/my_form_box.dart';
import 'package:invoice_gen/components/boxes/my_form_box2.dart';
import 'package:invoice_gen/components/boxes/my_form_box3.dart';
import 'package:invoice_gen/components/buttons/my_button.dart';
import 'package:invoice_gen/components/my_app_bar.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';

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
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                children:[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
              [
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                Image.asset('assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.2),
              ],),

              const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "BILL TO")])),

              MyFormBox3(text: customer.name, text2: customer.address, text3: customer.tin),

              Column(
                  children: [
                    const SizedBox(height: 30, child: Row(children: [MyTextGrey(text: "ITEMS")])),
                    ...items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: 
                      MyFormBox(text: item.name)
                      
                    )).toList()]),
              ]),   
               const SizedBox(height: 30,
              child: Row(children: [ MyTextGrey(text: "Details")])),
              
              MyFormBox3(text: details.id, text2: details.issuance, text3: details.place),
              MyFormBox2(text:Utils.formatDate(details.dateOfSale), text2:Utils.formatDate(details.dateOfPayment)),
 
              const SizedBox(height: 80),
              Center(
              child: MyButton(text: "Save",
                callback: () async{
                      context.read<InvoiceBloc>().add(CompleteInvoiceEvent());                
                  }))
              ])
              ),
               
            )));
  }
}
