import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/widgets/rounded_checkbox.dart';
import '../../../data/models/config_response.payment_method.dart';

class PaymentMethodListItem extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final Function() onPressed;
  final bool hide ;

  const PaymentMethodListItem({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onPressed,
    this.hide = false
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(), minimumSize: const Size(0, 0),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: paymentMethod.logo,
            width: 24.w,
            height: 24.h,
            placeholder: (context, url) => const CircularProgressIndicator(),
          ),
          const SizedBox(width: 12),
          Text(paymentMethod.name, style: context.labelLarge),
          const Spacer(),
          RoundedCheckbox(isSelected: isSelected)
        ],
      ),
    );
}
