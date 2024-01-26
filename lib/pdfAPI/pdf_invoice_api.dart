import 'package:flutter/services.dart';
import 'package:invoice_gen/classes/invoice.dart';
import 'package:invoice_gen/classes/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:invoice_gen/classes/supplemetary.dart';


class PdfInvoiceApi {
  static Future<Uint8List> generate(Invoice invoice, PdfColor color) async{
    final pdf = Document();
    final muktaRegular = await loadMuktaRegularFont();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, muktaRegular),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice,muktaRegular),
        buildInvoice(invoice,muktaRegular,color),
        Divider(),
        buildTotal(invoice,muktaRegular, color),
      ],
      footer: (context) => buildFooter(invoice),
    ));
    return convertDocumentToPdfData(pdf);
  }
  static Future<Document> generateForPrinting(Invoice invoice, PdfColor color) async{
    final pdf = Document();
    final muktaRegular = await loadMuktaRegularFont();


    pdf.addPage(MultiPage(
      build: (context)  => [
        buildHeader(invoice, muktaRegular),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice,muktaRegular),
        buildInvoice(invoice,muktaRegular,color),
        Divider(),
        buildTotal(invoice,muktaRegular,color),
      ],
    ));
    return pdf;
  }
  
  static Future<Uint8List> convertDocumentToPdfData(pw.Document document) async {
  return document.save();
}

  static Widget buildHeader(Invoice invoice, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.seller, font),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.details.id,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer,font),
              buildInvoiceInfo(invoice, font),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Company customer, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(customer.name, style: TextStyle(font:  font)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(Invoice invoice, pw.Font font) {
    final info = invoice.details;
    final paymentTerms = '${info.dateOfPayment.difference(info.dateOfSale).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
      'Due Date:'
    ];
    final data = <String>[
      info.id,
      Utils.formatDate(info.dateOfSale),
      paymentTerms,
      Utils.formatDate(info.dateOfPayment),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200, font: font);
      }),
    );
  }

  static Widget buildSupplierAddress(Company supplier, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Supplier", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(supplier.name, style: TextStyle(font: font)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address, style: TextStyle(font: font)),
        ],
      );

  static Widget buildTitle(Invoice invoice, pw.Font font) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, font: font),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice, pw.Font font, PdfColor color)  {
    final headers = [
      'Product',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
    final total = item.price * item.quantity * (1 + (item.tax * 0.01));

      return [
        (item.name),
        '${item.quantity}',
        '\$ ${item.price}',
        '${item.tax} %',
        '\$ ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(font: font),
      headerDecoration:  BoxDecoration(color: color),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice, pw.Font font, PdfColor color) {
    double netTotal = 0;
    double totalVat = 0;

  for (var item in invoice.items) {
    double itemTotal = item.price * item.quantity;
    netTotal += itemTotal;
    totalVat += itemTotal * (item.tax * 0.01); 
  }

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                  font: font,
                ),
                buildText(
                  title: 'Vat ${invoice.items[0].tax} %',
                  value: Utils.formatPrice(totalVat),
                  unite: true,
                  font: font
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  font: font,
                  value: Utils.formatPrice(netTotal + totalVat),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: color),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: color),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.seller.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Paypal', value: invoice.seller.tin),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

     return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: <Widget> [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ]);
  }

  static buildText({
    required String title,
    required String value,
    required pw.Font font,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : TextStyle(font: font)),
        ],
      ),
    );
  }
  static Future<pw.Font> loadMuktaRegularFont() async {
    final fontData = await rootBundle.load('assets/fonts/Mukta/Mukta-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

}