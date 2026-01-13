import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import '../../../core/theme/color_palette.dart';
import '../../waypoint/provider/selected_loc_text_field_providers.dart';
import '../../notifications/provider/notification_providers.dart';
import '../provider/home_map_providers.dart';

// Separate widget to prevent repeated API calls
class _NotificationIcon extends ConsumerStatefulWidget {
  const _NotificationIcon();

  @override
  ConsumerState<_NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends ConsumerState<_NotificationIcon> {
  bool _hasLoadedInitialCount = false;

  @override
  void initState() {
    super.initState();
    // Load unread count only once when widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasLoadedInitialCount) {
        _hasLoadedInitialCount = true;
        ref.read(unreadCountNotifierProvider.notifier).getUnreadCount();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch unread count (this doesn't trigger API calls, just watches state)
    final unreadState = ref.watch(unreadCountNotifierProvider);
    final unreadCount = unreadState.maybeWhen(success: (count) => count, orElse: () => 0);

    return InkWell(
      onTap: () {
        // Navigate to notifications page
        NavigationService.pushNamed(AppRoutes.notificationsPage);
        // Refresh unread count when returning (only after navigation)
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            ref.read(unreadCountNotifierProvider.notifier).refresh();
          }
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
        child: Badge(
          isLabelVisible: unreadCount > 0,
          label: Text(
            unreadCount > 99 ? '99+' : unreadCount.toString(),
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          child: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class HomeMapAppbar extends StatelessWidget {
  final bool isDark;
  const HomeMapAppbar({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) => ClipRect(
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF397098), Color(0xFF942FAF)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Content area
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [locationAndCountrySelection(context), const Gap(12), searchBar(context)],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget locationAndCountrySelection(BuildContext context) => Consumer(
    builder: (context, ref, _) {
      final homeMapState = ref.watch(homeMapNotifierProvider);
      return Row(
        children: [
          Assets.images.locationPin.image(height: 24, width: 24, fit: BoxFit.fill),
          const Gap(4),
          Expanded(
            child: Text(
              homeMapState.address ?? AppLocalizations.of(context).fetching_address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          const Gap(8),
          // Notification icon button - Navigate to notifications page
          _NotificationIcon(),
        ],
      );
    },
  );

  Widget searchBar(BuildContext context) => Consumer(
    builder: (context, WidgetRef ref, _) => InkWell(
      onTap: () {
        ref.read(selectedLocTextFieldNotifierProvider.notifier).resetState();
        NavigationService.pushNamed(AppRoutes.searchDestinationPage);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: context.surface, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF687387), size: 24),
            const Gap(8),
            Expanded(
              child: Text(
                AppLocalizations().search_destination,
                style: context.bodyMedium?.copyWith(
                  color: const Color(0xFF687387),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 16,
              width: 1,
              color: const Color(0xFFD7DAE0),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Assets.images.locationPin.image(height: 20, width: 18, fit: BoxFit.fill, color: ColorPalette.primary50),
          ],
        ),
      ),
    ),
  );
}
