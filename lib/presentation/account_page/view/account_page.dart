import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../core/utils/delete_account_dialogue.dart';
import '../../../core/utils/get_version.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/widgets/country_code_bottom_sheet.dart';
import '../../profile/provider/rider_details_provider.dart';
import '../provider/select_country_provider.dart';
import '../provider/theme_provider.dart';

Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  String version = '';

  @override
  void initState() {
    super.initState();
    loadVersion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(riderDetailsNotifierProvider.notifier).getRiderDetails();
    });
  }

  Future<void> loadVersion() async {
    version = await getVersion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: Text(
          AppLocalizations.of(context).account,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDarkMode() ? Colors.white : Colors.white,
          ),
        ),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF397098), Color(0xFF942FAF)],
            ),
          ),
        ),

        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: isDark ? AppColors.surface : Colors.white,
      body: Column(
        children: [
          Container(height: 8.h, width: double.infinity, color: isDark ? Colors.black : const Color(0xFFF6F7F9)),
          userDetails(context),
          Gap(8.h),
          accountDetails(context, ref: ref, isDark: isDark, version: version),
        ],
      ),
    );
  }
}

Widget userDetails(BuildContext context) => Padding(
  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
  child: InkWell(
    onTap: () {
      LocalStorageService().getUserId();
    },
    child: Column(
      children: [
        Container(
          height: 160.h,
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(image: Assets.images.bg.provider(), fit: BoxFit.fill),
          ),
          child: Consumer(
            builder: (context, ref, _) {
              final riderDetails = ref
                  .watch(riderDetailsNotifierProvider)
                  .mapOrNull(success: (data) => data.data.data, error: (error) => null);

              final name = riderDetails?.user?.name;
              final firstLetter = (name != null && name.trim().isNotEmpty) ? name.trim()[0].toUpperCase() : 'U';

              return Column(
                children: [
                  CircleAvatar(
                    radius: 38.r,
                    backgroundColor: Colors.white,
                    child: riderDetails?.user?.profilePicture != null && riderDetails!.user!.profilePicture!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: riderDetails.user!.profilePicture!,
                                height: 72.r,
                                width: 72.r,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Color(0xFF397098), Color(0xFF942FAF)],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (riderDetails.user?.name ?? 'U').trim().isNotEmpty
                                          ? riderDetails.user!.name!.trim()[0].toUpperCase()
                                          : 'U',
                                      style: context.bodyMedium?.copyWith(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Color(0xFF397098), Color(0xFF942FAF)],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (riderDetails.user?.name ?? 'U').trim().isNotEmpty
                                          ? riderDetails.user!.name!.trim()[0].toUpperCase()
                                          : 'U',
                                      style: context.bodyMedium?.copyWith(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 72.r,
                            height: 72.r,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF397098), Color(0xFF942FAF)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                firstLetter,
                                style: context.bodyMedium?.copyWith(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                  Gap(8.h),
                  Text(
                    riderDetails?.user?.name ?? 'N/A',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    riderDetails?.user?.mobile ?? 'N/A',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white60,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  ),
);

Widget accountDetails(BuildContext context, {required WidgetRef ref, required bool isDark, String? version}) => Expanded(
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          accountButton(
            context,
            leading: Assets.images.myProfile.image(height: 24.h, width: 24.w, fit: BoxFit.fill),
            title: AppLocalizations.of(context).my_profile,
            onTap: () {
              NavigationService.pushNamed(AppRoutes.profileInfoPage);
            },
            isDark: isDark,
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.changePassword.image(height: 24.h, width: 24.w, fit: BoxFit.fill),
            title: AppLocalizations.of(context).change_password,
            onTap: () => NavigationService.pushNamed(AppRoutes.changePassword),
            isDark: isDark,
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.terms.image(height: 24.h, width: 24.w, fit: BoxFit.fill),
            title: AppLocalizations.of(context).terms_conditions,
            onTap: () {
              _launchUrl('https://gleaming-begonia-69d7b2.netlify.app/terms');
            },
            isDark: isDark,
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.privacy.image(height: 24.h, width: 24.w, fit: BoxFit.fill),
            title: AppLocalizations.of(context).privacy_policy,
            onTap: () {
              _launchUrl('https://gleaming-begonia-69d7b2.netlify.app/privacy-policy');
            },
            isDark: isDark,
          ),
          Gap(8.h),
          Consumer(
            builder: (context, refs, _) => accountButton(
              context,
              leading: Assets.images.logOut.image(height: 24.h, width: 24.w, fit: BoxFit.fill),
              title: AppLocalizations.of(context).log_out,
              onTap: () {
                showExitLogoutDialogue(ref: refs, isLogout: true);
              },
              isDark: isDark,
            ),
          ),
          Gap(8.h),
          accountButton(
            context,
            leading: Assets.images.trash.image(height: 24.h, width: 24.w, fit: BoxFit.fill),
            title: AppLocalizations.of(context).delete_account,
            onTap: () {
              showDeleteAccountDialog();
            },
            isDark: isDark,
          ),
        ],
      ),
    ),
  ),
);

Widget accountButton(
  BuildContext context, {
  Function()? onTap,
  Widget? leading,
  required String title,
  required bool isDark,
  Widget? trailing,
}) => InkWell(
  onTap: onTap,
  child: Container(
    constraints: BoxConstraints(minHeight: 48.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: isDark ? Colors.black : const Color(0xFFF6F7F9),
    ),
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    // margin: EdgeInsets.only(bottom: 8.h),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16.0.w),
          child: leading ?? const SizedBox.shrink(),
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF363A44),
            ),
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    ),
  ),
);

class ThemeSwitchTile extends ConsumerStatefulWidget {
  const ThemeSwitchTile({super.key});

  @override
  ConsumerState<ThemeSwitchTile> createState() => _ThemeSwitchTileState();
}

class _ThemeSwitchTileState extends ConsumerState<ThemeSwitchTile> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = isDarkMode();
  }

  void _toggleTheme() {
    setState(() {
      isDark = !isDark;
    });

    ref.read(themeModeProvider.notifier).setTheme(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: isDark ? Colors.grey.shade900 : const Color(0xFFF6F7F9),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: GestureDetector(
      onTap: _toggleTheme,
      child: Container(
        width: 54.w,
        height: 24.h,
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: isDark ? Colors.grey.shade900 : const Color(0xFFEDEEF0),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22.r,
            height: 22.r,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade700 : Colors.white,
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))],
            ),
            child: Center(
              child: Icon(isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded, size: 16.sp, color: Colors.blue),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget countrySelector({bool showDecoration = false}) => Consumer(
  builder: (BuildContext context, WidgetRef ref, Widget? child) => InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const CountryCodeBottomSheet(selectCountryCode: false),
      );
    },
    child: Container(
      padding: showDecoration ? EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w) : null,
      decoration: showDecoration
          ? BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
            )
          : null,
      child: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(selectedCountry);

          if (state.selectedLang == null) {
            return const SizedBox.shrink();
          }
          return IntrinsicWidth(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildNetworkImage(
                  imageUrl: state.selectedLang!.flag,
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.fill,
                  // filterQuality: FilterQuality.high,
                  // isAntiAlias: true,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    state.selectedLang?.code ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: showDecoration ? Colors.white : null,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: showDecoration ? Colors.white : Colors.black, size: 18.h),

                // Gap(8.h)
              ],
            ),
          );
        },
      ),
    ),
  ),
);
