import 'dart:io';

import 'package:flutter/material.dart';

SafeArea safeArea({required Widget child,
bool? enableTopForAll,
  bool? enableBottomForAll,
  bool? enableLeftForAll,
  bool? enableRightForAll,
}){
  final isIos =  Platform.isIOS;
  return SafeArea(
    top: enableTopForAll ?? isIos,
      left: enableLeftForAll ?? isIos,
      right: enableRightForAll ?? isIos,
      bottom: enableBottomForAll ?? isIos,
      child: child);
}