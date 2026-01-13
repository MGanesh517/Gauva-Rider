import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

Widget buildNetworkImage({
  required String? imageUrl,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  Widget? placeholder,
  Widget? errorWidget,
  double? errorIconSize = 50,
}) {
  if (imageUrl == null || imageUrl.trim().isEmpty) {
    return errorWidget ?? Icon(Icons.broken_image, size: errorIconSize, color: Colors.grey);
  }

  // PERFORMANCE OPTIMIZATION: Helper function to safely convert to int
  // Prevents errors when width/height is Infinity or NaN
  int? _safeToInt(double? value) {
    if (value == null) return null;
    // Check for Infinity, NaN, or invalid values
    if (!value.isFinite || value.isNaN || value.isInfinite) return null;
    // Check for valid positive range
    if (value <= 0 || value > 10000) return null; // Max reasonable image size
    try {
      return value.toInt();
    } catch (e) {
      return null;
    }
  }

  int? _safeToIntDouble(double? value) {
    if (value == null) return null;
    // Check for Infinity, NaN, or invalid values
    if (!value.isFinite || value.isNaN || value.isInfinite) return null;
    // Check for valid positive range before multiplying
    if (value <= 0 || value > 5000) return null; // Max reasonable size before 2x (5000 * 2 = 10000)
    try {
      final doubled = value * 2;
      // Check if doubled value is still finite
      if (!doubled.isFinite || doubled.isNaN || doubled.isInfinite) return null;
      return doubled.toInt();
    } catch (e) {
      return null;
    }
  }

  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: fit,
    // PERFORMANCE OPTIMIZATION: Enhanced caching settings
    // Cache images for 7 days (banners, avatars, etc. don't change frequently)
    maxWidthDiskCache: _safeToIntDouble(width), // Cache at 2x resolution for retina displays
    maxHeightDiskCache: _safeToIntDouble(height),
    memCacheWidth: _safeToInt(width), // Reduce memory usage
    memCacheHeight: _safeToInt(height),
    // Use fadeInDuration for smoother loading
    fadeInDuration: const Duration(milliseconds: 200),
    fadeOutDuration: const Duration(milliseconds: 100),
    placeholder: (context, url) =>
        placeholder ??
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: (width != null && width.isFinite && !width.isNaN) ? width : null,
            height: (height != null && height.isFinite && !height.isNaN) ? height : null,
            color: Colors.white,
          ),
        ),
    errorWidget: (context, url, error) =>
        errorWidget ?? Icon(Icons.error_outline, size: errorIconSize, color: Colors.redAccent),
  );
}
