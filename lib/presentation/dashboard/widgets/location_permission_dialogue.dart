import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/dashboard/provider/home_map_providers.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';

class CustomLocationPermissionDialog extends StatelessWidget {
  final Function() onAllow;

  const CustomLocationPermissionDialog({
    super.key,
    required this.onAllow,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min, // <- This makes dialog wrap content
            children: [
              Assets.images.locationMarker.image(
                height: 100.h,
                width: 100.w,
                fit: BoxFit.contain,
              ),
              Gap(16.h),
              Text(
                AppLocalizations.of(context).find_you_faster,
                style: context.headlineSmall?.copyWith(fontSize: 24.sp),
                textAlign: TextAlign.center,
              ),
              Gap(8.h),
              Text(
                AppLocalizations.of(context).find_you_faster_msg,
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
                      onPressed: onAllow,
                      child: Text(
                        AppLocalizations.of(context).allow,
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

Future<LatLng?> showLocationPermissionPrompt( ref, {bool withoutRef = false}) async {

  final context = NavigationService.navigatorKey.currentContext!;
  final homeMapRepo = ref.read(homeMapRepoProvider);


  final hasPermission = await hasLocationPermission();


  if (!hasPermission && context.mounted) {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CustomLocationPermissionDialog(
        onAllow: () async {
          Navigator.pop(context); // close dialog
        },
      ),
    );
  }

  final LatLng? currentLocation = await homeMapRepo.getUserLocation();
  // if(currentLocation != null){
  //   homeMapNotifier.updateCurrentLocationMarkerAddress(currentLocation);
  // }
  return currentLocation;
}

Future<bool> hasLocationPermission()async{
  final serviceEnable = await Geolocator.isLocationServiceEnabled();
  final LocationPermission permission = await Geolocator.checkPermission();

  return serviceEnable && !(LocationPermission.denied == permission || LocationPermission.deniedForever == permission);

  // final permissionGranted = await Permission.location.status;
  // final PermissionStatus permissionGranted = await Location().hasPermission();
  // return permissionGranted.isGranted;
  // return permissionGranted == PermissionStatus.granted;
}