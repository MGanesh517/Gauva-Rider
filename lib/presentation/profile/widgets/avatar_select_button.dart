import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/utils/color_palette.dart';
import '../../../gen/assets.gen.dart';
import '../../profile/provider/rider_details_provider.dart';
import 'select_profile_image_dialog.dart';

class AvatarSelectButton extends ConsumerWidget {
  final String? avatarPath;
  const AvatarSelectButton({super.key, required this.avatarPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final riderDetails = ref
        .watch(riderDetailsNotifierProvider)
        .maybeWhen(success: (data) => data.data?.user, orElse: () => null);

    // Get first letter of name for placeholder
    final firstLetter = (riderDetails?.name ?? 'U').trim().isNotEmpty
        ? riderDetails!.name!.trim()[0].toUpperCase()
        : 'U';

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 156.h,
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(image: Assets.images.profileBg.provider(), fit: BoxFit.fill),
          ),
        ),
        Center(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              showDialog(context: context, useSafeArea: false, builder: (context) => const SelectProfileImageDialog());
            },
            minimumSize: const Size(0, 0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 62.r,
                  backgroundColor: ColorPalette.primary50,
                  child: avatarPath != null && avatarPath!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: avatarPath!,
                              height: 120.h,
                              width: 120.w,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFF397098), Color(0xFF942FAF)],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    firstLetter,
                                    style: context.bodyMedium?.copyWith(
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFF397098), Color(0xFF942FAF)],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    firstLetter,
                                    style: context.bodyMedium?.copyWith(
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF397098), Color(0xFF942FAF)],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              firstLetter,
                              style: context.bodyMedium?.copyWith(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
                Positioned(
                  bottom: 4.r,
                  right: 4.r,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorPalette.primary50),
                    padding: EdgeInsets.all(8.r),
                    child: Icon(Ionicons.camera, color: Colors.white, size: 18.h),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
