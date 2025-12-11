import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/country_code.dart';
import 'package:gauva_userapp/data/repositories/interfaces/country_list_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/country_list_service_interface.dart';
import '../../core/errors/failure.dart';
import '../models/country_code_model/country_code_model.dart';
import 'base_repository.dart';


class CountryListRepoImpl extends BaseRepository implements ICountryListRepo {
  final ICountryListService service;

  CountryListRepoImpl(this.service);
  @override
  Future<Either<Failure, CountryCodeModel>> getCountryList() async => await safeApiCall(() async {
    debugPrint('🌍 GET COUNTRY LIST');
    final response = await service.getCountryList();
    debugPrint('📥 GET COUNTRY LIST Response: ${response.data}');
    debugPrint('📥 Response Type: ${response.data.runtimeType}');
    
    try {
      // Handle array response directly (API returns empty array [])
      if (response.data is List) {
        debugPrint('📦 COUNTRY LIST - Array response detected');
        if ((response.data as List).isEmpty) {
          debugPrint('⚠️ COUNTRY LIST - Empty array, using hardcoded list');
          return CountryCodeModel(
            message: 'Using default countries',
            countries: [],
          );
        }
        
        // Parse array items as CountryCode objects
        final countries = (response.data as List)
            .map((item) => CountryCode.fromJson(item))
            .toList();
        debugPrint('✅ COUNTRY LIST - Parsed ${countries.length} countries from array');
        return CountryCodeModel(
          message: 'Countries loaded',
          countries: countries,
        );
      }
      
      // Handle object response {message: ..., countries: [...]}
      final result = CountryCodeModel.fromJson(response.data);
      debugPrint('✅ COUNTRY LIST - Parsed successfully from object');
      debugPrint('✅ Countries count: ${result.countries?.length ?? 0}');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 COUNTRY LIST - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      debugPrint('🔴 Raw response data: ${response.data}');
      // Return empty country model on error (will use hardcoded list)
      return CountryCodeModel(message: 'Using default countries', countries: []);
    }
  });
}
