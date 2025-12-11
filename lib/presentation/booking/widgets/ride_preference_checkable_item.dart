import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/utils/color_palette.dart';

class RidePreferenceCheckableItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? fee;
  final String? currency;
  final bool isSelected;
  final Function(bool) onChanged;
  final bool isDark;

  const RidePreferenceCheckableItem({
    super.key,
    required this.title,
    required this.icon,
    this.fee,
    this.currency,
    required this.isSelected,
    required this.onChanged, required this.isDark,
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onChanged(!isSelected);
      }, minimumSize: const Size(0, 0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              style: context.labelLarge,
            ),
          ),
          Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              side: const BorderSide(),
              value: isSelected,
              onChanged: (_) {
                onChanged(!isSelected);
              },
              fillColor: WidgetStatePropertyAll(isDark ? Colors.white : Colors.black),
          )
        ],
      ),
    );

  Color get borderColor =>
      isSelected ? ColorPalette.primary40 : ColorPalette.neutral90;

  Color get backgroundColor =>
      isSelected ? ColorPalette.primary95 : ColorPalette.neutralVariant95;
}
