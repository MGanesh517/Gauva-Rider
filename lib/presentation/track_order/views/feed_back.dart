import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/presentation/payment_method/provider/provider.dart';
import 'package:gauva_userapp/presentation/track_order/provider/rating_provider.dart';

import '../../../data/models/order_response/order_model/order/order.dart';
import '../../../generated/l10n.dart';

Widget feedback(BuildContext context, Order order, {required bool isDark}) => Column(
  children: [
    Assets.images.payComplete.image(height: 100.h, width: 91.w, fit: BoxFit.fill),
    Gap(16.h),
    Text(
      AppLocalizations.of(context).payment_completed,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
      ),
    ),
    Gap(4.h),
    Consumer(
      builder: (context, ref, _) {
        final selectedPaymentMethod = ref.watch(selectedPayMethodProvider);
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorPalette.primary50,
            ),
            text:
                r'$'
                '${order.payableAmount?.toString() ?? '0.00'} ',
            children: [
              TextSpan(
                style: context.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF687387),
                ),
                text: AppLocalizations.of(context).payment_confirmation(selectedPaymentMethod?.value ?? ''),
              ),
            ],
          ),
        );
      },
    ),
    Gap(16.h),
    RatingAndComment(order: order, isDark: isDark),
  ],
);

class RatingAndComment extends StatefulWidget {
  const RatingAndComment({super.key, required this.order, required this.isDark});
  final Order order;
  final bool isDark;

  @override
  State<RatingAndComment> createState() => _RatingAndCommentState();
}

class _RatingAndCommentState extends State<RatingAndComment> {
  double rating = 2.5;
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: widget.isDark ? Colors.black : const Color(0xFFF6F7F9),
            ),
            child: RatingBar.builder(
              initialRating: 2.5,
              minRating: 1,
              allowHalfRating: true,
              itemSize: 32.h,
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (r) => setState(() => rating = r),
              unratedColor: Colors.grey.shade800,
            ),
          ),
          Gap(16.h),
          TextField(
            controller: commentController,
            maxLines: 3,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              hintText: AppLocalizations.of(context).share_experience,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          Gap(16.h),
          Consumer(
            builder: (context, ref, _) {
              final ratingStateNotifier = ref.read(ratingNotifierProvider.notifier);
              final ratingState = ref.watch(ratingNotifierProvider);
              final bool isLoading = ratingState.whenOrNull(loading: () => true) ?? false;
              return AppPrimaryButton(
                isDisabled: isLoading,
                isLoading: isLoading,
                onPressed: () {
                  if (commentController.text.isEmpty) {
                    showNotification(message: AppLocalizations.of(context).enter_experience);
                    return;
                  }
                  ratingStateNotifier.rating(
                    rating: rating,
                    comment: commentController.text.trim(),
                    orderId: widget.order.id,
                  );
                },
                child: Text(
                  AppLocalizations.of(context).submit,
                  style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
