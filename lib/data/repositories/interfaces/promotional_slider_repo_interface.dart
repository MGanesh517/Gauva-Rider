import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/promotional_slider_model/promotional_slider_model.dart';
import '../../../core/errors/failure.dart';

abstract class IPromotionalSliderRepo {
  Future<Either<Failure, PromotionalSliderModel>> getPromotionalData();
}
