import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/place_model.dart';
import '../view_model/search_place_notifier.dart';
import 'google_api_providers.dart';

final searchPlaceNotifierProvider = StateNotifierProvider<SearchPlaceNotifier, AsyncValue<List<PlaceModel>>>(
    (ref) => SearchPlaceNotifier(ref: ref, googleAPIRepo: ref.read(googleAPIRepoProvider)));
