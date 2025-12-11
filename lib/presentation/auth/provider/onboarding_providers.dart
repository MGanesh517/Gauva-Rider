import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/onboarding_notifier.dart';

final onboardingNotifierProvider = StateNotifierProvider<OnboardingNotifier, int>((ref) => OnboardingNotifier());
