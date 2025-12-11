import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/banner_model/banner_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/banner_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/banner_service_interface.dart';
import '../../core/errors/failure.dart';
import 'base_repository.dart';

class BannerRepoImpl extends BaseRepository implements IBannerRepo {
  final IBannerService service;

  BannerRepoImpl({required this.service});

  @override
  Future<Either<Failure, List<BannerModel>>> getBanners() async =>
      await safeApiCall(() async {
        debugPrint('🎯 GET BANNERS');
        final response = await service.getBanners();
        debugPrint('📥 GET BANNERS Response: ${response.data}');
        debugPrint('📥 Response Type: ${response.data.runtimeType}');

        try {
          // Handle array response directly (Spring Boot returns array of banners)
          if (response.data is List) {
            debugPrint('📦 BANNERS - Array response detected');
            final banners = (response.data as List)
                .map((item) => BannerModel.fromJson(item))
                .where((banner) => banner.active == true) // Filter only active banners
                .toList();
            
            // Sort by displayOrder
            banners.sort((a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
            
            debugPrint('✅ BANNERS - Parsed ${banners.length} active banners from array');
            return banners;
          }

          // Handle wrapped response {data: [...]}
          if (response.data is Map && response.data.containsKey('data')) {
            final bannersList = response.data['data'] as List;
            final banners = bannersList
                .map((item) => BannerModel.fromJson(item))
                .where((banner) => banner.active == true)
                .toList();
            
            banners.sort((a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
            
            debugPrint('✅ BANNERS - Parsed ${banners.length} active banners from wrapped response');
            return banners;
          }

          // Return empty list if no banners found
          debugPrint('⚠️ BANNERS - No banners found in response');
          return <BannerModel>[];
        } catch (e, stackTrace) {
          debugPrint('🔴 BANNERS - Parsing error: $e');
          debugPrint('🔴 Stack trace: $stackTrace');
          debugPrint('🔴 Raw response data: ${response.data}');
          // Return empty list on error
          return <BannerModel>[];
        }
      });
}

