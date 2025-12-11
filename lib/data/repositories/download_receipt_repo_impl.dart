import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/download_receipt_model/download_receipt_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/download_receipt_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/download_receipt_service_interface.dart';

import '../../core/errors/failure.dart';
import 'base_repository.dart';

class DownloadReceiptRepoImpl extends BaseRepository implements IDownloadReceiptRepo {
  final IDownloadReceiptService downloadReceiptService;

  DownloadReceiptRepoImpl(this.downloadReceiptService);
  @override
  Future<Either<Failure, DownloadReceiptModel>> getDownloadLink({int? id}) async => await safeApiCall(() async {
      final response = await downloadReceiptService.getDownloadLink(id: id);
      return DownloadReceiptModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, File>> download({String? url}) async => await safeApiCall(() async {
      final response = await downloadReceiptService.download(url);
      final bool does = await  response.exists();
      if(does){
        return response;
      }else{
        throw Exception('something went wrong');
      }
    });
}
