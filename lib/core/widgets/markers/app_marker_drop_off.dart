import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'app_marker.dart';

class AppMarkerDropOff extends StatelessWidget {
  final String? address;
  const AppMarkerDropOff({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) => AppMarker(
      showPickUp: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Destination',
            style: context.labelMedium,
          ),
          Text(
            address ?? 'Drag to adjust',
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              color: context.theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
}
