import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/markers/app_marker.dart';

class AppMarkerStop extends StatelessWidget {
  final String? address;
  final int stopIndex;

  const AppMarkerStop({
    super.key,
    required this.stopIndex,
    this.address,
  });

  @override
  Widget build(BuildContext context) => AppMarker(
      // color: MarkerColor.green,
      // icon: MarkerIcon.location,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Stop $stopIndex',
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
