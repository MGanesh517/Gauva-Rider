import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../gen/assets.gen.dart';

class BrokenPage extends ConsumerWidget {
  const BrokenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();

    return ExitAppWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(height: 16.h, width: double.infinity, color: isDark ? Colors.black : ColorPalette.neutralF6,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                        color: context.surface,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r), bottom: Radius.circular(16.r))
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Assets.images.broken.image(height: 200.h, width: 200.w),
                        Gap(24.h),
                        Text(AppLocalizations.of(context).unexpected_application_crash, textAlign: TextAlign.center, style: context.bodyMedium?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700, color: const Color(0xFF24262D)),),
                        Gap(8.h),
                        Text(AppLocalizations.of(context).app_encountered_unexpected_error, textAlign: TextAlign.center, style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF464D5E)),),
                        Gap(24.h),
                        AppPrimaryButton(
                            backgroundColor: Colors.white,

                            onPressed: ()async{
                              await openWhatsApp(phoneNumber: '+8801336909483');
                            }, child: Text(AppLocalizations.of(context).contact_support, style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorPalette.primary50),))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> openWhatsApp({required String phoneNumber}) async {
    final whatsappUrl = 'whatsapp://send?phone=$phoneNumber&text=';

    final uri = Uri.parse(whatsappUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // fallback - যদি অ্যাপ না থাকে, তাহলে browser এ wa.me খুলবে
      final fallback = Uri.parse('https://wa.me/$phoneNumber?text=');
      await launchUrl(fallback, mode: LaunchMode.externalApplication);
    }
  }
}

