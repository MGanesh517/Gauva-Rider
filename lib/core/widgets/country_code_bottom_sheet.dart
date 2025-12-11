import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/app_country_code_list_item.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../data/models/country_code.dart';
import '../../presentation/account_page/provider/select_country_provider.dart';

class CountryCodeBottomSheet extends ConsumerStatefulWidget {
  final bool selectCountryCode;
  const CountryCodeBottomSheet({super.key, required this.selectCountryCode,
  });

  @override
  ConsumerState<CountryCodeBottomSheet> createState() => _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState extends ConsumerState<CountryCodeBottomSheet> {
  List<CountryCode> filteredCountryCodes = [];

  void setCountryCodeList() {
    filteredCountryCodes = getCountryCodeList();
    setState(() {});
  }

  List<CountryCode> getCountryCodeList(){
    final state = ref.read(selectedCountry);
    return widget.selectCountryCode ? state.phoneCountryList : state.langCountryList;
  }

    void filterCountryCodes(String query) {
      setState(() {
        filteredCountryCodes = getCountryCodeList()
            .where((countryCode) => countryCode.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
      });
    }

    @override
    void initState() {
      super.initState();
      setCountryCodeList();
    }

    @override
    Widget build(BuildContext context) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          color: context.surface
      ),
      child: Column(
        children: [
          Gap(16.h),

          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Ionicons.search),
              hintText: AppLocalizations.of(context).select_a_country,
              fillColor: context.surface,
            ),
            onChanged: filterCountryCodes,
          ),
          Consumer(builder: (context, ref, _) {
            final selectedCountryCode = ref.watch(selectedCountry);
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemBuilder: (context, index) {
                  final item = filteredCountryCodes[index];
                  return AppCountryCodeListItem(
                    countryCode: item,
                    isSelected: (widget.selectCountryCode ? selectedCountryCode.selectedPhoneCode : selectedCountryCode.selectedLang) == item,
                    onPressed: (newValue) {

                      if (widget.selectCountryCode) {
                        ref.read(selectedCountry.notifier).setPhoneCode(newValue);
                      }else{
                        ref.read(selectedCountry.notifier).setCountry(newValue,);
                      }

                      Navigator.pop(context);
                    },
                    selectCountryCode: widget.selectCountryCode,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 8,
                  indent: 20,
                ),
                itemCount: filteredCountryCodes.length,
              ),
            );
          })
        ],
      ),
    );
  }

