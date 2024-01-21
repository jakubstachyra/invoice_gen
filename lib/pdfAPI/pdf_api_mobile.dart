import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

Future<File> downloadFileMobile(Document pdf, String name) async {
  final bytes = await pdf.save();
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$name.pdf');

  await file.writeAsBytes(bytes);
  return file;
}
