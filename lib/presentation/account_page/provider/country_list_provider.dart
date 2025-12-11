import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/country_code.dart';
import 'package:gauva_userapp/data/repositories/country_list_repo_impl.dart';
import 'package:gauva_userapp/data/repositories/interfaces/country_list_repo_interface.dart';
import 'package:gauva_userapp/data/services/country_list_service.dart';
import 'package:gauva_userapp/domain/interfaces/country_list_service_interface.dart';

import '../../../core/state/app_state.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/select_country_notifier.dart';

final countryListServiceProvider = Provider<ICountryListService>((ref) => CountryListService(dioClient: ref.read(dioClientProvider)));

final countryListRepoProvider = Provider<ICountryListRepo>((ref) => CountryListRepoImpl(ref.watch(countryListServiceProvider)));

final countryListProvider = StateNotifierProvider<CountryListNotifier, AppState<List<CountryCode>>>((ref) => CountryListNotifier(ref, ref.read(countryListRepoProvider)));