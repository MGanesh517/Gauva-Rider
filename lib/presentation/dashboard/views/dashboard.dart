import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/widgets/location_permission_wrapper.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/account_page/view/account_page.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/home_map.dart';
import 'package:gauva_userapp/presentation/notifications/provider/notification_providers.dart';
import 'package:gauva_userapp/presentation/ride_history/views/ride_history_page.dart';
import '../../../screens/user/wallet_screen.dart';
import 'package:gauva_userapp/presentation/websocket/provider/websocket_provider.dart';
import 'package:gauva_userapp/presentation/websocket/view_model/websocket_listener_notifier.dart';
import 'package:gauva_userapp/core/services/in_app_update_service.dart';

import '../../../core/utils/change_status_bar.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../account_page/provider/select_country_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setStatusBar(isHome: true, isDark: isDarkMode());
    Future.microtask(() => ref.read(selectedCountry.notifier));
    // Initialize WebSocket connection
    _initializeWebSocket();
    // Check for app updates
    _checkForUpdates();
    // Load unread notification count
    _loadUnreadCount();
  }

  void _loadUnreadCount() {
    // Load unread count after a short delay to avoid blocking app startup
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        ref.read(unreadCountNotifierProvider.notifier).getUnreadCount();
      }
    });
  }

  Future<void> _initializeWebSocket() async {
    try {
      await ref.read(websocketProvider.notifier).setupWebSocketListeners();
      // Start listening to WebSocket streams after connection
      Future.delayed(const Duration(seconds: 3), () {
        // Check if widget is still mounted before accessing ref
        if (mounted) {
          ref.read(websocketListenerNotifierProvider.notifier).startListening();
        }
      });
    } catch (e) {
      debugPrint('Failed to initialize WebSocket: $e');
    }
  }

  Future<void> _checkForUpdates() async {
    // Wait a bit before checking for updates to avoid blocking app startup
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      await InAppUpdateService.checkForUpdate(context);
    }
  }

  final List<Widget> _pages = const [HomeMap(), WalletScreen(), RideHistoryPage(), AccountPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      setStatusBar(isHome: index == 0, isDark: isDarkMode());
    });
  }

  bool isDark() => ref.watch(themeModeProvider) == ThemeMode.dark;

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: LocationPermissionWrapper(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: _selectedIndex == 0
            ? Colors.transparent
            : isDark()
            ? Colors.black
            : Colors.white,
        body: _pages[_selectedIndex],
        bottomNavigationBar: CustomBottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
      ),
    ),
  );
}
