import 'dart:convert';
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:pdf/widgets.dart';

void downloadFileWeb(Document pdf) async {
  var savedFile = await pdf.save();
  List<int> fileInts = List.from(savedFile);
  html.AnchorElement(
    href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}"
  )
    ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
    ..click();
}
void downloadFileWeb2 (Uint8List fileData, String fileName) {

  String base64Data = base64.encode(fileData);


  html.AnchorElement(
    href: "data:application/octet-stream;charset=utf-16le;base64,$base64Data"
  )
    ..setAttribute("download", fileName)
    ..click();
}
