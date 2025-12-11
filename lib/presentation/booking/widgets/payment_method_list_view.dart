import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../data/models/config_response.payment_method.dart';
import 'payment_method_list_item.dart';

class PaymentMethodListView extends StatefulWidget {
  final List<PaymentMethod> paymentMethods;
  final PaymentMethod? selectedPaymentMethod;
  final Function(PaymentMethod?) onSelected;

  const PaymentMethodListView({
    super.key,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onSelected,
  });

  @override
  State<PaymentMethodListView> createState() => _PaymentMethodListViewState();
}

class _PaymentMethodListViewState extends State<PaymentMethodListView> {
  PaymentMethod? paymentMethod;

  @override
  void initState() {
    paymentMethod = widget.selectedPaymentMethod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Text(
          'Select Payment Method S:',
          style: context.titleSmall,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = widget.paymentMethods[index];
              return PaymentMethodListItem(
                paymentMethod: item,
                isSelected: paymentMethod == item,
                onPressed: () {
                  setState(() => paymentMethod = item);
                  widget.onSelected(paymentMethod);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(
                indent: 24,
              ),
            itemCount: widget.paymentMethods.length,
          ),
        ),
      ],
    );
}
