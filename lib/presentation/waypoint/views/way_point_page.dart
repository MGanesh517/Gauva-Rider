import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import '../widgets/way_point_map.dart';

class WayPointPage extends ConsumerWidget {
  WayPointPage({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    key: _scaffoldKey,
    resizeToAvoidBottomInset: false,
    floatingActionButton: FloatingActionButton.small(
      onPressed: () => Navigator.of(context).pop(),
      child: Icon(
        Ionicons.arrow_back,
        color: ref.read(themeModeProvider.notifier).isDarkMode() ? Colors.white : Colors.black87,
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    body: const WayPointMap(),
  );
}
