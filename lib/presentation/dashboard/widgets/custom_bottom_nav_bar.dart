import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import '../../../gen/assets.gen.dart';
import 'navigation_card.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final bool isDark = theme == ThemeMode.dark;
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: MediaQuery.of(context).padding.bottom + 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: const Offset(0, -2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, AppLocalizations.of(context).home, Assets.icons.home, isDark),
          _buildNavItem(1, AppLocalizations.of(context).wallet, Assets.icons.wallet, isDark),
          _buildNavItem(2, AppLocalizations.of(context).activity, Assets.icons.activity, isDark),
          _buildNavItem(3, AppLocalizations.of(context).account, Assets.icons.account, isDark),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, AssetGenImage iconAsset, bool isDark) => InkWell(
    onTap: () => onTap(index),
    child: NavBarItem(
      icon: iconAsset.image(height: 24, width: 24, fit: BoxFit.fill),
      label: label,
      selected: index == currentIndex,
      isDark: isDark,
    ),
  );
}
