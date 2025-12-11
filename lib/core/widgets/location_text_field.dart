import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';

import '../../data/models/waypoint.dart';
import '../../generated/l10n.dart';
import '../utils/color_palette.dart';

class LocationTextField extends StatefulWidget {
  final int index;
  final int totalCount;
  final Function(String?) onChanged;
  final Waypoint? initialValue;
  final Function() onFocused;
  final Function() onRemoveStop;
  final Function(int, FocusNode) onMapPressed;
  final Function(bool) onRemoved;
  final bool? isFocused;

  const LocationTextField({
    super.key,
    required this.onChanged,
    required this.index,
    required this.totalCount,
    required this.initialValue,
    required this.onFocused,
    required this.onRemoveStop,
    required this.onMapPressed,
    required this.onRemoved,
    this.isFocused,
  });

  @override
  State<LocationTextField> createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  bool isFocused = false;
  final focusNode = FocusNode();
  late TextEditingController _controller;
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue?.address;
    isFocused = widget.isFocused ?? false;
    _controller = TextEditingController(text: value);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        widget.onFocused();
      }
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    if (isFocused) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(covariant LocationTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue?.address != oldWidget.initialValue?.address) {
      _controller.text = widget.initialValue?.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused ? ColorPalette.primary50 : ColorPalette.primary95,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    labelText(context),
                    style: context.bodySmall?.copyWith(
                      color: ColorPalette.primary50,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Material(
                  child: TextFormField(
                    onChanged: (newValue) {
                      widget.onChanged(newValue);
                      setState(() {
                        value = newValue;
                      });
                    },
                    focusNode: focusNode,
                    controller: _controller,
                    maxLines: 2,
                    style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400,),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: hintText(context),
                      suffixIcon: Transform.translate(
                        offset: const Offset(0, -8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if ((value?.isNotEmpty ?? false) ||
                                (widget.index != 0 &&
                                    widget.index != (widget.totalCount - 1)))
                              CupertinoButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                onPressed: () {
                                  widget.onRemoved(true);
                                  if (_controller.text.isEmpty &&
                                      widget.index != 0 &&
                                      widget.index != widget.totalCount - 1) {
                                    widget.onRemoveStop();
                                    return;
                                  }
                                  _controller.clear();
                                  widget.onChanged(null);
                                }, minimumSize: const Size(0, 0),
                                child: const Icon(
                                  Ionicons.close_circle,
                                  size: 18,
                                  color: ColorPalette.neutralVariant80,
                                ),
                              ),
                            Container(
                              width: 1,
                              height: 16,
                              color: ColorPalette.neutral80,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                  
                            GestureDetector(
                              onTap: ()=> widget.onMapPressed(widget.index, focusNode),
                              child: Container(
                                height: 35.h,
                                width: 35.w,
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xFFF1F7FE),
                                ),
                                child: Assets.images.locationPin.image(height: 19.5.h, width: 17.5.w, fit: BoxFit.fill, color: ColorPalette.primary50),
                              ),
                            )
                          ],
                        ),
                      ),
                      // fillColor: Colors.white,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  Color labelColor(BuildContext context) => isFocused
      ? context.theme.colorScheme.primary
      : context.theme.colorScheme.onSurfaceVariant;

  String labelText(BuildContext context) => widget.index == 0
      ? AppLocalizations.of(context).pickup
      : ((widget.index < (widget.totalCount - 1))
          ? AppLocalizations.of(context).stop_point
          : AppLocalizations.of(context).destination);

  String hintText(BuildContext context) => widget.index == 0
      ? AppLocalizations.of(context).enter_pickup_point
      : ((widget.index < (widget.totalCount - 1))
          ? AppLocalizations.of(context).enter_stop_point
          : AppLocalizations.of(context).enter_destination);
}
