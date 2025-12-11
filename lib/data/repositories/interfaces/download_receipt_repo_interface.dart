import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/download_receipt_model/download_receipt_model.dart';

import '../../../core/errors/failure.dart';

abstract class IDownloadReceiptRepo {
  Future<Either<Failure, DownloadReceiptModel>> getDownloadLink({int? id});
  Future<Either<Failure, File>> download({String? url});
}
