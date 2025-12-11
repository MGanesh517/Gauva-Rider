import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/delete_account_service.dart';
import '../models/common_response.dart';
import 'base_repository.dart';
import 'interfaces/delete_repo_interface.dart';


class DeleteAccountRepoImpl extends BaseRepository implements IDeleteAccountRepo {
  final IDeleteAccountService _deleteAccountService;

  DeleteAccountRepoImpl(this._deleteAccountService);
  @override
  Future<Either<Failure, CommonResponse>> deleteAccount() async {
    final data = await safeApiCall(() async {
      final response = await _deleteAccountService.deleteAccount();
      return CommonResponse.fromMap(response.data);
    });
    data.fold((l) => l, (r) => r);
    return data;
  }
}
