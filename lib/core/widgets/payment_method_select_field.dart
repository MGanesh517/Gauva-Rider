import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/models/payment_methods_model/payment_methods_model.dart';

import '../../generated/l10n.dart';
import '../utils/color_palette.dart';

class PaymentMethodSelectField extends StatelessWidget {
  final PaymentMethods? paymentMethod;
  final Function() onPressed;
  final bool readOnly;
  final bool isDark;

  const PaymentMethodSelectField({
    super.key,
    required this.paymentMethod,
    required this.onPressed,
    this.readOnly = false, required this.isDark
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: readOnly ? null : onPressed, minimumSize: const Size(0, 0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            icon(context),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: paymentMethod == null
                          ? Text(
                        AppLocalizations.of(context).select_payment_method,
                              style: context.labelMedium?.copyWith(
                                color: textColor,
                              ),
                            )
                          : Text(
                              paymentMethod?.value?.capitalize() ?? '',
                              style: context.labelMedium?.copyWith(
                                color: textColor,
                              ),
                            )),
                ],
              ),
            ),
            Icon(
              Ionicons.chevron_forward,
              color: chevronColor,
              size: 16,
            )
          ],
        ),
      ),
    );

  Color get borderColor =>
      paymentMethod != null ? ColorPalette.primary95 :ColorPalette.secondary90;
  Color get backgroundColor =>
      paymentMethod != null ? Colors.transparent :  isDark ? Colors.black : ColorPalette.secondary99;

  Color get textColor =>
      paymentMethod != null ?  isDark ? Colors.white : ColorPalette.neutral10 : ColorPalette.secondary20;

  Color get chevronColor =>
      paymentMethod != null ? ColorPalette.neutral70 : ColorPalette.secondary40;

  Color get iconColor =>
      paymentMethod != null ? ColorPalette.primary30 : ColorPalette.secondary40;

  Widget icon(BuildContext context) => paymentMethod != null
      ? CachedNetworkImage(imageUrl: paymentMethod!.logo ?? '', width: 24, height: 24)
      : Icon(
          Ionicons.card,
          size: 24,
          color: iconColor,
        );
}

