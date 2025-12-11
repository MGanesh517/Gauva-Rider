import 'package:flutter/material.dart';

import '../../../core/utils/color_palette.dart';
import '../widgets/booking_map.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorPalette.neutralVariant99,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: const BookingMap(),
    );
}
