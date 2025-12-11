import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/utils/exit_app_dialogue.dart';

class NoInternetPage extends ConsumerWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();
    return ExitAppWrapper(
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).no_internet_connection,
            style: context.bodyLarge?.copyWith(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 5,
          backgroundColor: isDark ? Colors.black : Colors.white,
        ),
        body: Center(
          child: SvgPicture.asset(
            'assets/svg/no-internet.svg',
            colorFilter: ColorFilter.mode(isDark ? ColorPalette.primary80 : ColorPalette.primary50, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
