import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import '../../theme/color_palette.dart';

class AppPrimaryButton extends ConsumerWidget {
  final Function()? onPressed;
  final Widget child;
  final bool isDisabled;
  final PrimaryButtonColor color;
  final Color? backgroundColor;
  final bool isLoading;
  final double width;
  final bool showBorder;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isDisabled = false,
    this.isLoading = false,
    this.color = PrimaryButtonColor.primary,
    this.backgroundColor,
    this.width = double.infinity,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.read(themeModeProvider.notifier).isDarkMode();

    // Use gradient for primary buttons
    final bool useGradient = backgroundColor == null && color == PrimaryButtonColor.primary;

    return SafeArea(
      bottom: !isIos(),
      child: Container(
        decoration: useGradient && !isDisabled
            ? BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF397098), Color(0xFF942FAF)],
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: ElevatedButton(
          onPressed: (isDisabled || isLoading) ? null : onPressed,
          style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(width, 48)),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 16)),
            backgroundColor: useGradient
                ? const WidgetStatePropertyAll(Colors.transparent)
                : backgroundColor != null
                ? WidgetStatePropertyAll(isDark ? Colors.black : backgroundColor)
                : color == PrimaryButtonColor.primary
                ? primaryButtonBackground(context)
                : errorButtonBackground(context),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: const WidgetStatePropertyAll(0),
            shape: backgroundColor == null && !useGradient
                ? null
                : WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: showBorder && !useGradient
                          ? const BorderSide(color: ColorPalette.primary50)
                          : BorderSide.none,
                    ),
                  ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : child,
        ),
      ),
    );
  }

  WidgetStateProperty<Color> primaryButtonBackground(BuildContext context) => WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return context.theme.colorScheme.onSurface.withValues(alpha: 0.12);
    } else if (states.contains(WidgetState.hovered)) {
      return context.colorScheme.primary;
    } else if (states.contains(WidgetState.pressed)) {
      return ColorPalette.primary40;
    } else {
      return context.colorScheme.primary;
    }
  });

  WidgetStateProperty<Color> errorButtonBackground(BuildContext context) => WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return context.theme.colorScheme.onSurface.withValues(alpha: 0.12);
    } else if (states.contains(WidgetState.hovered)) {
      return ColorPalette.error50;
    } else if (states.contains(WidgetState.pressed)) {
      return ColorPalette.error30;
    } else {
      return ColorPalette.error40;
    }
  });
}

enum PrimaryButtonColor { primary, error }
