import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  final String pickup;
  final String dropOff;
  final String time;
  final String duration;
  final String distance;
  final String fare;
  final String status;

  const RideCard({
    super.key,
    required this.pickup,
    required this.dropOff,
    required this.time,
    required this.duration,
    required this.distance,
    required this.fare,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isCancelled = status == 'CANCELLED';
    final statusColor = isCancelled ? Colors.red : Colors.green;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, color: Colors.green, size: 12),
                      Expanded(
                        child: Container(
                          width: 2,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Icon(Icons.location_on, color: Colors.red, size: 16),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pickup, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(dropOff, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: Theme.of(context).textTheme.bodySmall),
                Text(duration, style: Theme.of(context).textTheme.bodySmall),
                Text(distance, style: Theme.of(context).textTheme.bodySmall),
                Text(fare, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
