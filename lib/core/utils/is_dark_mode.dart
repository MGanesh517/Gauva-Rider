import 'package:flutter/material.dart';

import '../../data/services/navigation_service.dart';

bool isDarkMode() => Theme.of(NavigationService.navigatorKey.currentContext!).brightness == Brightness.dark;
