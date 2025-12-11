import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../presentation/account_page/provider/theme_provider.dart';

class ExitAppWrapper extends StatelessWidget {
  final Widget child;
  final bool canPop;
  final Function()? onExit;
  const ExitAppWrapper({super.key, required this.child, this.onExit, this.canPop = false});

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (v,d)async{
          if(!v){
            final shouldExit = await showExitLogoutDialogue( isLogout: false);
            if(shouldExit){
              if(onExit != null){
                onExit!();
              }
            }

          }

        },
        child: GestureDetector(child: child, onTap: (){
          FocusScope.of(context).unfocus();
        },));
}

class ExitLogOut extends StatelessWidget {
  final Function() onAllow;
  final Function() onCancel;
  final bool isLogout;

  const ExitLogOut({
    super.key,
    required this.onAllow, required this.isLogout, required this.onCancel,
  });

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, _) {
      final isDark = ref.read(themeModeProvider.notifier).isDarkMode();
      return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: isDark ? const BorderSide(color: Colors.white) : BorderSide.none),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.exitLogo.image(
                    height: 60.h,
                    width: 60.w,
                    fit: BoxFit.contain,
                  ),
                  Gap(16.h),
                  Text(
                    AppLocalizations.of(context).are_you_sure_msg(isLogout ? AppLocalizations.of(context).log_out : AppLocalizations.of(context).exit),
                    style: context.headlineSmall?.copyWith(fontSize: 24.sp),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8.h),
                  Text(
                    AppLocalizations.of(context).see_you_next_ride,
                    style: context.headlineSmall?.copyWith(
                      color: const Color(0xFF687387),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(24.h),
                  Row(
                    children: [
                      Expanded(
                        child: AppPrimaryButton(
                          backgroundColor: ColorPalette.neutral100,
                          onPressed: onAllow,
                          child: Text(
                            isLogout ? AppLocalizations.of(context).log_out : AppLocalizations.of(context).exit,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.primary50),
                          ),
                        ),
                      ),
                      Gap(16.w),
                      Expanded(
                        child: AppPrimaryButton(
                          backgroundColor: const Color(0xFFEB5A3C),
                          showBorder: false,
                          onPressed: onCancel,
                          child: Text(
                            AppLocalizations.of(context).cancel,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.neutral100),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
    }
  );
}

Future<bool> showExitLogoutDialogue({WidgetRef? ref, required bool isLogout})  async{
  final context = NavigationService.navigatorKey.currentContext!;

     final bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (_) => ExitLogOut(
        onCancel: (){
          Navigator.of(context).pop(false);
        },
        onAllow: () async {
         if(isLogout){
           await ref?.read(logoutNotifierProvider.notifier).logout();
         }else{
           SystemNavigator.pop();
         }
        }, isLogout: isLogout,
      ),
    );
     return shouldExit ?? false;
}
