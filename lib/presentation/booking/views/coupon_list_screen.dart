import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/coupon_model/coupon_model.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import '../provider/coupon_providers.dart';

class CouponListScreen extends ConsumerStatefulWidget {
  const CouponListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends ConsumerState<CouponListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(couponNotifierProvider.notifier).getAvailableCoupons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final couponState = ref.watch(couponNotifierProvider);
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();

    return Scaffold(
      appBar: AppBar(title: const Text("Available Coupons")),
      body: couponState.when(
        initial: () => const SizedBox(),
        loading: () => const Center(child: LoadingView()),
        error: (failure) => Center(child: Text(failure.message)),
        success: (coupons) {
          if (coupons.isEmpty) {
            return const Center(child: Text("No coupons available"));
          }
          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: coupons.length,
            separatorBuilder: (context, index) => Gap(12.h),
            itemBuilder: (context, index) {
              final coupon = coupons[index];
              return _buildCouponCard(context, coupon, isDark);
            },
          );
        },
      ),
    );
  }

  Widget _buildCouponCard(BuildContext context, CouponModel coupon, bool isDark) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, coupon);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    coupon.code,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "APPLY",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.green),
                    ),
                  ),
                ],
              ),
              Gap(8.h),
              Text(
                coupon.type == "PERCENT" ? "Get ${coupon.value}% off" : "Get ₹${coupon.value} flat discount",
                style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.grey[400] : Colors.grey[700]),
              ),
              if (coupon.minFare != null) ...[
                Gap(4.h),
                Text(
                  "Min Fare: ₹${coupon.minFare}",
                  style: TextStyle(fontSize: 12.sp, color: isDark ? Colors.grey[500] : Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
