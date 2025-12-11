import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/utils/color_palette.dart';

class UploadImageField extends StatelessWidget {
  final String? imageUrl;
  final void Function(String)? onChanged;
  final BoxShape shape;
  final double? borderRadius;
  final String uploadButtonText;

  const UploadImageField({
    super.key,
    this.shape = BoxShape.circle,
    this.imageUrl,
    this.borderRadius,
    required this.uploadButtonText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      InkWell(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
            border: Border.all(color: const Color(0xffe2e8f0), width: 8),
          ),
          child: imageUrl != null
              ? Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: shape,
                    borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius! * 0.5) : null,
                  ),
                  child: imageUrl!.contains('http') || imageUrl!.contains('https')
                      ? CachedNetworkImage(imageUrl: imageUrl!, width: 60, height: 60, fit: BoxFit.cover)
                      : Image.file(File(imageUrl!), width: 60, height: 60, fit: BoxFit.cover),
                )
              : InkWell(
                  onTap: _onTap,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: shape,
                      borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius! * 0.5) : null,
                      color: const Color(0xfff4f5fe),
                    ),
                    child: const Icon(Ionicons.cloud_upload, color: ColorPalette.primary30),
                  ),
                ),
        ),
      ),
      const SizedBox(height: 16),
      CupertinoButton(
        padding: const EdgeInsets.all(0),
        onPressed: _onTap,
        minimumSize: const Size(0, 0),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorPalette.primary99,
            border: Border.all(color: ColorPalette.primary95),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            uploadButtonText,
            style: context.labelMedium?.copyWith(color: context.theme.colorScheme.onSurfaceVariant),
          ),
        ),
      ),
    ],
  );

  void _onTap() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final media = result.files.single.path!;
      onChanged?.call(media);
    }
  }
}
