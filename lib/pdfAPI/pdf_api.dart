import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_gen/blocs/invoice_color/functions_color.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/supplemetary.dart';
import 'package:invoice_gen/components/my_texts/my_text.dart';
import 'package:invoice_gen/pdfAPI/pdf_api_mobile.dart';
import 'package:invoice_gen/pdfAPI/pdf_api_web.dart';
import 'package:invoice_gen/pdfAPI/pdf_invoice_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:printing/printing.dart';

class PdfApi {
 static Future<void> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    if (kIsWeb) {
      downloadFileWeb(pdf);
    } else {
      await downloadFileMobile(pdf, name);
    }
  }

static Future<void> saveFile(BuildContext context,Invoice invoice) async
{
  String? message;
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  
  try{
     
      final response = await PdfInvoiceApi.generate(invoice, await InvoiceColorPreferences.getDefaultInvoiceColor());
      if(kIsWeb)
      {
        downloadFileWeb2(response,"${invoice.details.id}.pdf");
      }
      else{
      final dir = await getTemporaryDirectory();

      var filename = '${dir.path}/${invoice.details.id}.pdf';

      final file = File(filename);
      await file.writeAsBytes(response);

      final params = SaveFileDialogParams(sourceFilePath: filename);

      final finalPath = await FlutterFileDialog.saveFile(params: params);
      if(finalPath !=null)
      {
        message = "Invoice saved";
      }
      }

  }catch(e)
  {
    message = "Error with file";
  }
  if(message != null){
    scaffoldMessenger.showSnackBar(SnackBar(content: MyTextGrey(text: message)));
  }
}

static List<Map<String, dynamic>> itemsToMapList(List<Item> items) {
  return items.map((item) => item.toMap()).toList();
}
static Future<void> uploadInvoice(Company seller, Company customer, List<Item> items, Details details) async {

  var sellerJson = seller.toMap();
  var customerJson = customer.toMap();
  var detailsJson = details.toMap();
  var itemsJson = itemsToMapList(items);

  User? currentUser = FirebaseAuth.instance.currentUser;
  final invoice = FirebaseFirestore.instance.collection('userFiles').doc(currentUser!.uid).collection('invoices').doc();

    var combinedData = {
    'seller': sellerJson,
    'customer': customerJson,
    'items': itemsJson,
    'details': detailsJson,
    'id': invoice.id,
  };


  await invoice.set(combinedData);
}
static Future<List<Invoice>> downloadData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    throw Exception("User not logged in");
  }

  CollectionReference collection = FirebaseFirestore.instance.collection('userFiles').doc(currentUser.uid).collection('invoices');

  QuerySnapshot querySnapshot = await collection.get();

  return querySnapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Company seller = Company.fromMap(data['seller']);
    Company customer = Company.fromMap(data['customer']);
    Details details = Details.fromMap(data['details']);
    List<Item> items = (data['items'] as List).map((item) => Item.fromMap(item)).toList();
    String id = (data["id"]);
    return Invoice(seller, customer, items, details, id);
  }).toList();
}
static Future<void> deleteResourceFromFirestore(String resourceId) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    throw Exception("User not logged in");
  }
 final invoice =  FirebaseFirestore.instance.collection('userFiles').doc(currentUser.uid).collection('invoices').doc(resourceId);
 invoice.delete();
}

static Future<void> updateData(String invoiceId, Company seller, Company customer, List<Item> items, Details details) async {

  var sellerJson = seller.toMap();
  var customerJson = customer.toMap();
  var detailsJson = details.toMap();
  var itemsJson = itemsToMapList(items);

  User? currentUser = FirebaseAuth.instance.currentUser;
  final invoice = FirebaseFirestore.instance.collection('userFiles').doc(currentUser!.uid).collection('invoices').doc(invoiceId);

  var updatedData = {
    'seller': sellerJson,
    'customer': customerJson,
    'items': itemsJson,
    'details': detailsJson,
  };

  await invoice.update(updatedData);
}
static void print(Invoice invoice) async{

  final pdf = await PdfInvoiceApi.generateForPrinting(invoice, await InvoiceColorPreferences.getDefaultInvoiceColor());
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());

}

static Future<String> saveToTemp(BuildContext context, Invoice invoice) async {
  String? message;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  try {
    final pdfData = await PdfInvoiceApi.generate(invoice,await InvoiceColorPreferences.getDefaultInvoiceColor());

    if (kIsWeb) {
      // Dla aplikacji webowych, wyświetl PDF bezpośrednio w przeglądarce
      downloadFileWeb2(pdfData, "${invoice.details.id}.pdf");
      return "";
    } else {

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${invoice.details.id}.pdf');
      await file.writeAsBytes(pdfData);
      message = "";
      return file.path;
    }
  } catch (e) {
    message = "Save to temp error";
  }

  if (message.isEmpty == false) {
    scaffoldMessenger.showSnackBar(SnackBar(content: MyTextGrey(text: message)));
  }
  return "";
}
static Future<void> updateInvoiceStatus(String invoiceId, Status newStatus) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    throw Exception("User not logged in");
  }
  await firestore.collection('userFiles').doc(currentUser.uid).collection('invoices').doc(invoiceId).update({'status': newStatus});
}
}