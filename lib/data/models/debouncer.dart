import 'dart:async';

import 'package:flutter/cupertino.dart';

class DeBouncer {
  final Duration delay;
  VoidCallback? _action;
  Timer? _timer;

  DeBouncer({required this.delay});

  void call(VoidCallback action) {
    _action = action;
    _timer?.cancel();
    _timer = Timer(delay, () {
      _action?.call();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
