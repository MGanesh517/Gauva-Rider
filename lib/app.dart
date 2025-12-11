import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:gauva_userapp/core/config/fonts.dart';
import 'package:gauva_userapp/core/routes/app_router.dart';
import 'package:gauva_userapp/core/utils/change_status_bar.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.watch(themeModeProvider.notifier);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        setStatusBar(isDark: themeNotifier.isDarkMode());

        return ValueListenableBuilder<String>(
          valueListenable: LocalStorageService().languageNotifier,
          builder: (context, localeCode, _) => MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: dotenv.env['APP_NAME'] ?? '',
            themeMode: themeMode,
            theme: AppTheme.light(Fonts.primary, Fonts.secondary),
            darkTheme: AppTheme.dark(Fonts.primary, Fonts.secondary),
            locale: Locale(localeCode),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FormBuilderLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRoutes.splash,
          ),
        );
      },
    );
  }
}



