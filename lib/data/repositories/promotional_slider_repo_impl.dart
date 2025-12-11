import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/promotional_slider_model/promotional_slider_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/promotional_slider_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/promotional_slider_service_interface.dart';
import '../../core/errors/failure.dart';
import 'base_repository.dart';

class PromotionalSliderRepoImpl extends BaseRepository implements IPromotionalSliderRepo {
  final IPromotionalSliderService service;

  PromotionalSliderRepoImpl({required this.service});
  @override
  Future<Either<Failure, PromotionalSliderModel>> getPromotionalData() async => await safeApiCall(() async {
      debugPrint('🎪 GET PROMOTIONAL DATA');
      final response = await service.getPromotionalData();
      debugPrint('📥 GET PROMOTIONAL DATA Response: ${response.data}');
      debugPrint('📥 Response Type: ${response.data.runtimeType}');
      
      try {
        // Handle array response directly (Spring Boot returns array of promotions)
        if (response.data is List) {
          debugPrint('📦 PROMOTIONAL DATA - Array response detected');
          final promotions = (response.data as List)
              .map((item) => Promotions.fromJson(item))
              .toList();
          debugPrint('✅ PROMOTIONAL DATA - Parsed ${promotions.length} promotions from array');
          return PromotionalSliderModel(
            message: 'Promotions loaded',
            data: promotions,
          );
        }
        
        // Handle object response {message: ..., data: [...]}
        final result = PromotionalSliderModel.fromJson(response.data);
        debugPrint('✅ PROMOTIONAL DATA - Parsed successfully from object');
        debugPrint('✅ Promotions count: ${result.data?.length ?? 0}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 PROMOTIONAL DATA - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response data: ${response.data}');
        // Return empty promotional model on error
        return PromotionalSliderModel(message: 'No promotions', data: []);
      }
    });

}
