import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/rating_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/rating_service_interface.dart';

import '../../core/errors/failure.dart';
import 'base_repository.dart';

class RatingRepoImpl extends BaseRepository implements IRatingRepo {
  final IRatingService ratingService;

  RatingRepoImpl({required this.ratingService});

  @override
  Future<Either<Failure, CommonResponse>> rating({required double rating, String? comment, required int? orderId}) async => await safeApiCall(()async{
      debugPrint('⭐ SUBMIT RATING - Order: $orderId, Rating: $rating, Comment: $comment');
      final response = await ratingService.rating(rating: rating, comment: comment, orderId: orderId);
      debugPrint('📥 SUBMIT RATING Response: ${response.data}');
      try {
        final result = CommonResponse.fromMap(response.data);
        debugPrint('✅ SUBMIT RATING - Parsed successfully');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 SUBMIT RATING - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        throw Exception('Parsing error: $e');
      }

    });}