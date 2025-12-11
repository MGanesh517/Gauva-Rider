import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/banner_model/banner_model.dart';

abstract class IBannerRepo {
  Future<Either<Failure, List<BannerModel>>> getBanners();
}

