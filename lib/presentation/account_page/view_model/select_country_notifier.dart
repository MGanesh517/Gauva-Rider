import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/repositories/interfaces/country_list_repo_interface.dart';
import 'package:gauva_userapp/presentation/account_page/provider/select_country_provider.dart';

import '../../../core/config/country_codes.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/state/lang_code_state.dart';
import '../../../data/models/country_code.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../data/services/navigation_service.dart';

class SelectedCountryNotifier extends StateNotifier<LangCodeState> {
  final Ref ref;

  SelectedCountryNotifier(this.ref) : super(LangCodeState.empty()) {
    _init();
  }

  Future<void> _init() async {
    final savedLocale = await LocalStorageService().getSelectedLanguage();
    // Default to India (IN) for Indian market, fallback to saved locale, then India
    final CountryCode initialCountry = countryCodeList.firstWhere(
          (c) => c.languageCode == savedLocale,
      orElse: () => countryCodeList.firstWhere(
        (c) => c.code == 'IN',
        orElse: () => countryCodeList[0], // India is now first in list
      ),
    );
    
    // Always set India as default phone code on initialization
    final indiaCode = countryCodeList.firstWhere(
      (c) => c.code == 'IN',
      orElse: () => countryCodeList[0],
    );
    
    // Check saved phone code, but default to India if invalid
    final savedPhoneCode = await LocalStorageService().getPhoneCode();
    if (savedPhoneCode == null || savedPhoneCode.isEmpty || savedPhoneCode == '+880') {
      LocalStorageService().savePhoneCode(indiaCode.phoneCode!); // savePhoneCode is void, no await needed
    }
    
    // Set state with India as default phone code
    state = state.copyWith(
      selectedLang: initialCountry, 
      langCountryList: countryCodeList,
      selectedPhoneCode: indiaCode, // Always show India by default
    );
  }

  void setCountry(CountryCode countryCode,) {
    if(countryCode.languageCode == null)return;
    state = state.copyWith(selectedLang: countryCode);
    LocalStorageService().selectLanguage(countryCode.languageCode!);
    Future.delayed(const Duration(microseconds: 300)).then((_){
      Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        AppRoutes.splash,
            (route)=> false,
      );
    });
  }

  void setPhoneCode(CountryCode phoneCode){
    if(phoneCode.phoneCode == null)return;
    LocalStorageService().savePhoneCode(phoneCode.phoneCode!);
    state = state.copyWith(selectedPhoneCode: phoneCode);
  }

  void updatePhoneList(List<CountryCode> phoneList){
    if(phoneList.isEmpty) {
      // If API list is empty, use hardcoded list and set India
      final indiaCode = countryCodeList.firstWhere(
        (c) => c.code == 'IN',
        orElse: () => countryCodeList[0],
      );
      LocalStorageService().savePhoneCode(indiaCode.phoneCode!);
      state = state.copyWith(
        phoneCountryList: countryCodeList, 
        selectedPhoneCode: indiaCode
      );
      return;
    }
    // Default to India (IN) for Indian market, fallback to first in list
    final initial = phoneList.firstWhere(
      (element) => element.code == 'IN', 
      orElse: () {
        // If India not in API list, try to find it in hardcoded list
        final indiaFromHardcoded = countryCodeList.firstWhere(
          (c) => c.code == 'IN',
          orElse: () => phoneList.first,
        );
        // Add India to the list if not present
        if (!phoneList.any((c) => c.code == 'IN')) {
          phoneList.insert(0, indiaFromHardcoded);
        }
        return indiaFromHardcoded;
      }
    );
    LocalStorageService().savePhoneCode(initial.phoneCode!);
    state = state.copyWith(phoneCountryList: phoneList, selectedPhoneCode: initial);
  }

  void reset()=> _init();

}


class CountryListNotifier extends StateNotifier<AppState<List<CountryCode>>> {
  final Ref ref;
  final ICountryListRepo _repo;
  CountryListNotifier(this.ref, this._repo) : super(const AppState.initial()) {
    getCountryList();
  }

  Future<void> getCountryList() async {
    state = const AppState.loading();
    final response = await _repo.getCountryList();
    response.fold(
          (failure) {
        state = AppState.error(failure);
      },
          (data) {
        state = AppState.success(data.countries ?? []);
        ref.read(selectedCountry.notifier).updatePhoneList(data.countries ?? []);
      },
    );
  }
}