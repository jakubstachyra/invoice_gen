import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static Future<ByteData> loadMuktaRegularFont() async {
    return await rootBundle.load('assets/fonts/Mukta/Mukta-Regular.ttf');
  }
}