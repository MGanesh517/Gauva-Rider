import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../utils/color_palette.dart';

class HeaderActionButtonItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color iconColor;

  const HeaderActionButtonItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onPressed,
    this.iconColor = ColorPalette.primary80,
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed, minimumSize: const Size(0, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.bodySmall
                        ?.copyWith(color: ColorPalette.neutralVariant50),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: iconColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        subTitle,
                        // textAlign: TextAlign.center,
                        style: context.labelLarge,
                      ),

                    ],
                  ),
                ],
              ),
            ),
            if (onPressed != null) ...[
              const SizedBox(width: 4),
              const Icon(
                Ionicons.chevron_forward,
                color: ColorPalette.neutral70,
                size: 16,
              ),
              const SizedBox(width: 4),
            ]
          ],
        ),
      ),
    );
}
