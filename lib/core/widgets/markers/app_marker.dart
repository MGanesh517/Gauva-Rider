import 'package:flutter/material.dart';

class AppMarker extends StatelessWidget {
  final Widget title;
  final bool showPickUp;

  const AppMarker({super.key, required this.title, this.showPickUp = true});

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: const BoxConstraints(maxWidth: 170, maxHeight: 55),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Color(0x1464748B), offset: Offset(2, 4), blurRadius: 8)],
            ),
            child: title,
          ),
          Container(height: 25, width: 2, color: Colors.black),
        ],
      ),
    ],
  );
}
