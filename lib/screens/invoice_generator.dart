// import 'package:flutter/material.dart';
// import '../pdf_generator.dart';
// import '../classes/invoice.dart';
// import '../classes/supplemetary.dart';

// class InvoiceGeneratorScreen extends StatefulWidget {
//   const InvoiceGeneratorScreen({super.key});

//   @override
//   _InvoiceGeneratorScreenState createState() => _InvoiceGeneratorScreenState();
// }

// class _InvoiceGeneratorScreenState extends State<InvoiceGeneratorScreen> {
//   final TextEditingController _sellerNameController = TextEditingController();
//   final TextEditingController _sellerAddressController =
//       TextEditingController();
//   final TextEditingController _sellerTinController = TextEditingController();

//   final TextEditingController _customerTinController = TextEditingController();
//   final TextEditingController _customerNameController = TextEditingController();
//   final TextEditingController _customerAddressController =
//       TextEditingController();

//   final TextEditingController _invoiceIssuanceController =
//       TextEditingController();
//   final TextEditingController _invoiceDateOfSaleController =
//       TextEditingController();
//   final TextEditingController _invoiceDateOfPaymentController =
//       TextEditingController();
//   final TextEditingController _invoiceIdController = TextEditingController();
//   final TextEditingController _invoicePlaceController = TextEditingController();
//   final TextEditingController _itemNameController = TextEditingController();
//   final TextEditingController _itemQuantityController = TextEditingController();
//   final TextEditingController _itemPriceController = TextEditingController();

//   List<String> itemNames = [];
//   List<int> itemQuantities = [];
//   List<double> itemPrices = [];

//   final _scrollOffset = 0.0; // Przechowuje aktualny stan suwaka

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               //Sekcja Szczegoly
//               const Text('Faktura', style: TextStyle(fontSize: 20)),
//               TextFormField(
//                 controller: _invoicePlaceController,
//                 decoration: const InputDecoration(labelText: 'Miejsce'),
//               ),
//               TextFormField(
//                 controller: _invoiceIssuanceController,
//                 decoration:
//                     const InputDecoration(labelText: 'Data wystawienia'),
//               ),
//               TextFormField(
//                 controller: _invoiceDateOfSaleController,
//                 decoration: const InputDecoration(labelText: 'Data sprzedaży'),
//               ),
//               TextFormField(
//                 controller: _invoiceDateOfPaymentController,
//                 decoration: const InputDecoration(labelText: 'Data płatności'),
//               ),
//               TextFormField(
//                 controller: _invoiceIdController,
//                 decoration: const InputDecoration(labelText: 'Numer faktury'),
//               ),
//               // Sekcja Sprzedawcy
//               const Text('Sprzedawca', style: TextStyle(fontSize: 20)),
//               TextFormField(
//                 controller: _sellerNameController,
//                 decoration:
//                     const InputDecoration(labelText: 'Nazwa Sprzedawcy'),
//               ),
//               TextFormField(
//                 controller: _sellerAddressController,
//                 decoration:
//                     const InputDecoration(labelText: 'Adres Sprzedawcy'),
//               ),
//               TextFormField(
//                   controller: _sellerTinController,
//                   decoration:
//                       const InputDecoration(labelText: 'NIP Sprzedawcy')),

//               const SizedBox(height: 20),

//               // Sekcja Nabywcy
//               const Text('Nabywca', style: TextStyle(fontSize: 20)),
//               TextFormField(
//                 controller: _customerNameController,
//                 decoration: const InputDecoration(labelText: 'Nazwa Nabywcy'),
//               ),
//               TextFormField(
//                 controller: _customerAddressController,
//                 decoration: const InputDecoration(labelText: 'Adres Nabywcy'),
//               ),
//               TextFormField(
//                   controller: _customerTinController,
//                   decoration: const InputDecoration(labelText: 'NIP Nabywcy')),
//               const SizedBox(height: 20),

//               // Sekcja Pozycje na fakturze
//               const Text('Pozycje na fakturze', style: TextStyle(fontSize: 20)),
//               TextFormField(
//                 controller: _itemNameController,
//                 decoration: const InputDecoration(labelText: 'Nazwa Pozycji'),
//               ),
//               TextFormField(
//                 controller: _itemQuantityController,
//                 decoration: const InputDecoration(labelText: 'Ilość'),
//               ),
//               TextFormField(
//                 controller: _itemPriceController,
//                 decoration: const InputDecoration(labelText: 'Cena za sztukę'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   itemNames.add(_itemNameController.text);
//                   itemQuantities.add(int.parse(_itemQuantityController.text));
//                   itemPrices.add(double.parse(_itemPriceController.text));
//                   _itemNameController.clear();
//                   _itemQuantityController.clear();
//                   _itemPriceController.clear();
//                 },
//                 child: const Text('Dodaj Pozycję'),
//               ),

//               // Wyświetlanie dodanych pozycji
//               const Text('Dodane Pozycje:', style: TextStyle(fontSize: 20)),
//               SizedBox(
//                 height: 300.0, // Wysokość obszaru z suwakiem
//                 child: Scrollbar(
//                   child: ListView.builder(
//                     controller: ScrollController(
//                       initialScrollOffset: _scrollOffset,
//                     ),
//                     shrinkWrap: true,
//                     itemCount: itemNames.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text('Nazwa: ${itemNames[index]}'),
//                         subtitle: Text(
//                             'Ilość: ${itemQuantities[index]}, Cena: ${itemPrices[index]}'),
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               // Przycisk do generowania faktury PDF
//               ElevatedButton(
//                 onPressed: () {
//                   Company seller = Company(_sellerNameController.text,
//                       _sellerAddressController.text, _sellerTinController.text);

//                   Company customer = Company(
//                       _customerNameController.text,
//                       _customerAddressController.text,
//                       _customerTinController.text);

//                   Details details = Details(
//                       _invoicePlaceController.text,
//                       _invoiceIssuanceController.text,
//                       _invoiceDateOfSaleController.text,
//                       _invoiceDateOfPaymentController.text,
//                       _invoiceIdController.text);

//                   List<String>? items = [];
//                   Invoice invoice = Invoice(seller, customer, items, details);
//                   PdfGenerator.generateInvoice(
//                     invoice,
//                   );
//                 },
//                 child: const Text('Generuj Fakturę PDF'),
//               ),
//             ],
//           ),
//         ));
//   }
// }
