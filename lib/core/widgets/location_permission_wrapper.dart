import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import '../../data/services/navigation_service.dart';
import '../../gen/assets.gen.dart';
import '../../generated/l10n.dart';
import '../../presentation/dashboard/provider/home_map_providers.dart';
import '../../presentation/dashboard/widgets/location_permission_dialogue.dart';
import '../routes/app_routes.dart';

class LocationPermissionWrapper extends ConsumerStatefulWidget {
  final Widget child;
  final String? pageName;

  const LocationPermissionWrapper({
    super.key,
    required this.child,
    this.pageName,
  });

  @override
  ConsumerState<LocationPermissionWrapper> createState() =>
      _LocationPermissionWrapperState();
}

class _LocationPermissionWrapperState
    extends ConsumerState<LocationPermissionWrapper>
    with WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checked = false;
      _checkPermission();
    }
  }

  Future<void> _checkPermission() async {
    final status = await Geolocator.checkPermission();
    setState(() {
      _hasPermission = status == LocationPermission.always || status == LocationPermission.whileInUse;
      _checked = true;
    });
  }

  // Future<void> _requestPermission()async{
  //
  // }
  Future<void> _requestPermission() async {

    final location = await showLocationPermissionPrompt(ref);

    if(location != null){
      ref.read(homeMapNotifierProvider.notifier).updateCurrentLocationMarkerAddress(location);
    }
    final status = await Geolocator.requestPermission();

    if (status == LocationPermission.always || status == LocationPermission.whileInUse) {
      setState(() {
        NavigationService.pushNamedAndRemoveUntil(
          widget.pageName ?? AppRoutes.dashboard,
        );
      });
    } else if (status == LocationPermission.denied || status == LocationPermission.deniedForever || status == LocationPermission.unableToDetermine) {
      // Go to app settings, and after comeback _checkPermission() will be triggered via lifecycle
      await openAppSettings();
    } else {
      await openAppSettings();
      setState(() {
        _hasPermission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_checked) {
      return const Scaffold(body: Center(child: LoadingView()));
    }

    if (_hasPermission) {
      return widget.child;
    }

    return _buildPermissionPage();
  }

  Widget _buildPermissionPage() => Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: context.surface,
      onPressed: _requestPermission,
      label: Text(AppLocalizations.of(context).grant_permission, style: context.bodyMedium?.copyWith(color: ref.read(themeModeProvider.notifier).isDarkMode() ? Colors.white: Colors.black),),
    ),
    body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.lottie.location.lottie(),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context).location_permission_needed,
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context).location_permission_msg,
                textAlign: TextAlign.center,
                style: context.bodyMedium?.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
