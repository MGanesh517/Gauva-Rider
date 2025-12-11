import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/country_code_model/country_code_model.dart';

import '../../../core/errors/failure.dart';

abstract class ICountryListRepo {
  Future<Either<Failure, CountryCodeModel>> getCountryList();
}
