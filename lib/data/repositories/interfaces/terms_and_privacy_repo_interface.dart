import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../models/privacy_and_policy_model/privacy_and_policy_model.dart';
import '../../models/terms_and_condition_model/terms_and_condition_model.dart';

abstract class ITermsAndPrivacyRepo {
  Future<Either<Failure, TermsAndConditionModel>> termsAndCondition();
  Future<Either<Failure, PrivacyAndPolicyModel>> privacyAndPolicy();
}
