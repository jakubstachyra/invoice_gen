
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

// import 'dart:io';
// import 'classes/invoice.dart';


// class PdfGenerator {
//   static Future<void> generateInvoice(Invoice invoice) async {
//     final pdf = pw.Document();


//     final font = pw.Font.ttf(await rootBundle.load("assets/fonts/Open_Sans/static/OpenSans-Italic.ttf"));
//     pdf.addPage(
//       pw.Page(
//         build: (context) {
//           return pw.Column(children: [
//             // pw.Column(
//             //   children: [
//             //     pw.Row(
//             //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             //         children: [
//             //           pw.Column(
//             //               children: [pw.Container(width: 300, height: 120)]),
//             //           pw.Positioned(
//             //               left: 100,
//             //               child: pw.Column(children: [
//             //                 pw.Container(
//             //                     width: 200,
//             //                     padding: const pw.EdgeInsets.all(1),
//             //                     // decoration: pw.BoxDecoration(
//             //                     //     border: pw.Border.all(
//             //                     //         color: PdfColors.grey300, width: 1),
//             //                     //     color: PdfColors.grey200),
//             //                     alignment: pw.Alignment.center,
//             //                     child: pw.Text('Miejsce wystawienia',
//             //                         style:  pw.TextStyle(fontSize: 10, font:font))),
//             //                 pw.Text(invoice.details.place,
//             //                     style: pw.TextStyle(fontSize: 10, font: font)),
//             //                 pw.Container(
//             //                     width: 200,
//             //                     padding: const pw.EdgeInsets.all(1),
//             //                     // decoration: pw.BoxDecoration(
//             //                     //     border: pw.Border.all(
//             //                     //         color: PdfColors.grey300, width: 1),
//             //                     //     color: PdfColors.grey200),
//             //                     alignment: pw.Alignment.center,
//             //                     child: pw.Text('Data wystawienia\n',
//             //                         style:  pw.TextStyle(fontSize: 10, font: font))),
//             //                 pw.Text(invoice.details.issuance,
//             //                     style: pw.TextStyle(fontSize: 10, font: font)),
//             //                 pw.Container(
//             //                     width: 200,
//             //                     padding: const pw.EdgeInsets.all(1),
//             //                     // decoration: pw.BoxDecoration(
//             //                     //     border: pw.Border.all(
//             //                     //         color: PdfColors.grey300, width: 1),
//             //                     //     color: PdfColors.grey200),
//             //                     alignment: pw.Alignment.center,
//             //                     child: pw.Text('Data sprzedazy',
//             //                         style:  pw.TextStyle(fontSize: 10, font: font))),
//             //                 pw.Text(invoice.details.dateOfSale,
//             //                     style:  pw.TextStyle(fontSize: 10, font: font)),
//             //               ])),
//             //         ]),
//             //   ],
//             // ),
//             // pw.Row(
//             //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     pw.Container(
//             //       width: 230,
//             //       padding: const pw.EdgeInsets.all(1),
//             //       decoration: pw.BoxDecoration(
//             //         border: pw.Border.all(
//             //           color: PdfColors.grey300,
//             //           width: 1,
//             //         ),
//             //         color: PdfColors.grey200,
//             //       ),
//             //       alignment: pw.Alignment.center,
//             //       child: pw.Text(
//             //         'Sprzedawca\n',
//             //         style:  pw.TextStyle(fontSize: 10, font: font),

//             //       ),
//             //     ),
//             //     pw.Container(
//             //       width: 230,
//             //       padding: const pw.EdgeInsets.all(1),
//             //       decoration: pw.BoxDecoration(
//             //         border: pw.Border.all(
//             //           color: PdfColors.grey300,
//             //           width: 1,
//             //         ),
//             //         color: PdfColors.grey200,
//             //       ),
//             //       alignment: pw.Alignment.center,
//             //       child: pw.Text(
//             //         'Nabywca\n',
//             //         style:  pw.TextStyle(fontSize: 10, font: font),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             // pw.Row(
//             //   mainAxisAlignment: pw.MainAxisAlignment.start,
//             //   children: [
//             //     pw.Column(
//             //       crossAxisAlignment:
//             //           pw.CrossAxisAlignment.start, // Wyrownaj tekst do lewej
//             //       children: [
//             //         pw.Text(invoice.seller.name,style: pw.TextStyle(fontSize: 10, font: font)),
//             //         pw.Text('NIP:${invoice.seller.tin}', style: pw.TextStyle(fontSize: 10, font: font)),
//             //         pw.Text(invoice.seller.address, style: pw.TextStyle(fontSize: 10, font: font)),
//             //       ],
//             //     ),
//                 pw.Column(
//                   crossAxisAlignment:
//                       pw.CrossAxisAlignment.start, 
//                   children: [
//                     pw.Text(invoice.seller.name, style: pw.TextStyle(fontSize: 10, font: font)),
//                     pw.Text('NIP:${invoice.seller.tin}',style: pw.TextStyle(fontSize: 10, font: font)),
//                     pw.Text(invoice.seller.address,style: pw.TextStyle(fontSize: 10, font: font)),
//                   ],
//                 ),
              
//             pw.Text('Faktura VAT ${invoice.details.id}',style: pw.TextStyle(fontSize: 10, font: font)),
//             pw.Text('Kwota: $invoice', style: pw.TextStyle(fontSize: 10, font: font))
//           ]);
//         },
//       ),
//     );
  
//    final output = await getTemporaryDirectory();
//    final file = File("${output.path}/example.pdf");
//    await file.writeAsBytes(await pdf.save());
//    uploadFile(invoice, file);
//     // Otwórz wygenerowany plik PDF
//     // Możesz użyć paczki `open_file` do otwierania pliku
//   }
// }
// Future uploadFile(Invoice invoice, File file) async {
//   final path ='invoices/${invoice.details.id}.pdf';

//   final ref = FirebaseStorage.instance.ref().child(path);
//   ref.putFile(file);
// }
