import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice_gen/pdfAPI/pdf_api_mobile.dart';
import 'package:invoice_gen/pdfAPI/pdf_api_web.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';

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

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
Future uploadFile(String filePath, String userId) async {
  File file = File(filePath);

  try {
    await FirebaseStorage.instance
      .ref('userFiles/$userId/file.pdf')
      .putFile(file);
  } on FirebaseException catch (e) {
    Text(e.toString());
  }
}

}