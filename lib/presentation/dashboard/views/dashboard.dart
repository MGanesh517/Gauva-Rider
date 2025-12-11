import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/widgets/location_permission_wrapper.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/account_page/view/account_page.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/home_map.dart';
import 'package:gauva_userapp/presentation/ride_history/views/ride_history_page.dart';
import 'package:gauva_userapp/presentation/wallet/views/wallet_page.dart';
import 'package:gauva_userapp/presentation/websocket/provider/websocket_provider.dart';
import 'package:gauva_userapp/presentation/websocket/view_model/websocket_listener_notifier.dart';

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
  }

  Future<void> _initializeWebSocket() async {
    try {
      await ref.read(websocketProvider.notifier).initializeFromStorage();
      // Start listening to WebSocket streams after connection
      Future.delayed(const Duration(seconds: 3), () {
        ref.read(websocketListenerNotifierProvider.notifier).startListening();
      });
    } catch (e) {
      debugPrint('Failed to initialize WebSocket: $e');
    }
  }

  final List<Widget> _pages = const [HomeMap(), WalletPage(), RideHistoryPage(), AccountPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      setStatusBar(isHome: index == 0, isDark: isDarkMode());
    });
  }

  bool isDark() => ref.watch(themeModeProvider) == ThemeMode.dark;

  // @override
  // Widget build(BuildContext context) => ExitAppWrapper(
  //     child: LocationPermissionWrapper(
  //       child: Container(
  //         color: _selectedIndex == 0 ? Colors.transparent : isDark() ? Colors.black : Colors.white,
  //         child: Column(
  //           children: [
  //             // Custom status bar container - transparent for home page to show gradient
  //             Container(
  //               height: MediaQuery.of(context).viewPadding.top,
  //               width: double.infinity,
  //               decoration: _selectedIndex == 0
  //                   ? const BoxDecoration(
  //                       gradient: LinearGradient(
  //                         begin: Alignment.topCenter,
  //                         end: Alignment.bottomCenter,
  //                         colors: [Color(0xFF397098), Color(0xFF942FAF)],
  //                       ),
  //                     )
  //                   : BoxDecoration(
  //                       color: isDark() ? Colors.black : Colors.white,
  //                     ),
  //             ),
  //             Expanded(
  //               child: Scaffold(
  //                 key: _scaffoldKey,
  //                 // Add this to remove any automatic SafeArea
  //                 body: MediaQuery.removePadding(
  //                   context: context,
  //                   removeTop: true,
  //                   child: _pages[_selectedIndex],
  //                 ),
  //                 bottomNavigationBar: CustomBottomNavBar(
  //                   currentIndex: _selectedIndex,
  //                   onTap: _onItemTapped,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );

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
