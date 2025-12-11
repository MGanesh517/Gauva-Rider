import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';


class PlaceResultItem extends StatelessWidget {
  final String? title;
  final String subtitle;
  final String? trailing;
  final bool isRecent;
  final VoidCallback? onPressed;

  const PlaceResultItem({
    super.key,
    this.title,
    required this.subtitle,
    this.isRecent = false,
    required this.onPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0), minimumSize: const Size(0, 0),
      child: Row(
        children: [
          Assets.images.locationPin.image(height: 24.h, width: 24.w, fit: BoxFit.fill, color: const Color(0xFF687387)),
          const SizedBox(width: 12),
          Expanded(child: Text(
            subtitle,
            // "$subtitle, ${title ?? ''}",
            style: context.labelLarge?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
          ),),
        ],
      ),
    );
}
