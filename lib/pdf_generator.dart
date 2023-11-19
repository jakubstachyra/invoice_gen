import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'classes/invoice.dart';

class PdfGenerator {
  static Future<void> generateInvoice(Invoice invoice) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(children: [
            pw.Column(
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          children: [pw.Container(width: 300, height: 120)]),
                      pw.Positioned(
                          left: 100,
                          child: pw.Column(children: [
                            pw.Container(
                                width: 200,
                                padding: const pw.EdgeInsets.all(1),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColors.grey300, width: 1),
                                    color: PdfColors.grey200),
                                alignment: pw.Alignment.center,
                                child: pw.Text('Miejsce wystawienia',
                                    style: const pw.TextStyle(fontSize: 10))),
                            pw.Text(invoice.details.place,
                                style: const pw.TextStyle(fontSize: 10)),
                            pw.Container(
                                width: 200,
                                padding: const pw.EdgeInsets.all(1),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColors.grey300, width: 1),
                                    color: PdfColors.grey200),
                                alignment: pw.Alignment.center,
                                child: pw.Text('Data wystawienia\n',
                                    style: const pw.TextStyle(fontSize: 10))),
                            pw.Text(invoice.details.issuance,
                                style: const pw.TextStyle(fontSize: 10)),
                            pw.Container(
                                width: 200,
                                padding: const pw.EdgeInsets.all(1),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColors.grey300, width: 1),
                                    color: PdfColors.grey200),
                                alignment: pw.Alignment.center,
                                child: pw.Text('Data sprzedaży',
                                    style: const pw.TextStyle(fontSize: 10))),
                            pw.Text(invoice.details.dateOfSale,
                                style: const pw.TextStyle(fontSize: 10)),
                          ])),
                    ]),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 230,
                  padding: const pw.EdgeInsets.all(1),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.grey300,
                      width: 1,
                    ),
                    color: PdfColors.grey200,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Sprzedawca\n',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Container(
                  width: 230,
                  padding: const pw.EdgeInsets.all(1),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.grey300,
                      width: 1,
                    ),
                    color: PdfColors.grey200,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Nabywca\n',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment:
                      pw.CrossAxisAlignment.start, // Wyrownaj tekst do lewej
                  children: [
                    pw.Text(invoice.seller.name),
                    pw.Text('NIP:${invoice.seller.tin}'),
                    pw.Text(invoice.seller.address),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment:
                      pw.CrossAxisAlignment.start, // Wyrownaj tekst do lewej
                  children: [
                    pw.Text(invoice.seller.name),
                    pw.Text('NIP:${invoice.seller.tin}'),
                    pw.Text(invoice.seller.address),
                  ],
                ),
              ],
            ),
            pw.Text('Faktura VAT ${invoice.details.id}'),
            pw.Text('Kwota: $invoice', style: const pw.TextStyle(fontSize: 10))
          ]);
        },
      ),
    );

    const directory = "C:Faktury";
    final file = File('$directory/${invoice.details.id}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Otwórz wygenerowany plik PDF
    // Możesz użyć paczki `open_file` do otwierania pliku
  }
}
