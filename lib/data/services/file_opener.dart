import 'package:open_file/open_file.dart';
import 'dart:io';

class FileOpener {
  static Future<void> openFile(File file) async {
    final result = await OpenFile.open(file.path);

    if (result.type != ResultType.done) {
      throw Exception('Could not open file: ${result.message}');
    }
  }
}
