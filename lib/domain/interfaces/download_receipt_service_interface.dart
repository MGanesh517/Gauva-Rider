import 'dart:io';

import 'package:dio/dio.dart';

abstract class IDownloadReceiptService {
  Future<Response> getDownloadLink({int? id});
  Future<File> download(String? url);
}
