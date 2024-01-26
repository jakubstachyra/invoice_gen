import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceColorPreferences {
  static const String defaultColorKey = 'default_invoice_color';

  static Future<PdfColor> getDefaultInvoiceColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String colorHex = prefs.getString(defaultColorKey) ?? '#CCCCCC'; // Domyślny kolor
    return PdfColor.fromHex(colorHex);
  }

  static Future<void> setDefaultInvoiceColor(PdfColor color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String colorHex = color.toHex();
    await prefs.setString(defaultColorKey, colorHex);
  }

  static String getName(PdfColor color) {
    if (color == PdfColors.grey) {
      return 'Grey';
    } else {
      return 'Blue';
    }
  }
}
