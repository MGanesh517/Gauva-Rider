import 'package:flutter/cupertino.dart';
import '../../data/services/navigation_service.dart';

bool isArabic()=> Localizations.localeOf(NavigationService.navigatorKey.currentContext!).languageCode == 'ar';