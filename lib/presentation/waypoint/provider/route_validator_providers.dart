import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/route_validator_notifier.dart';

final routeValidatorNotifierProvider = StateNotifierProvider<RouteValidatorNotifier, bool>(
  (ref) => RouteValidatorNotifier(ref),
);
