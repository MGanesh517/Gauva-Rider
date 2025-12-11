import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../view_model/place_lat_lng_fetcher_notifier.dart';
import 'google_api_providers.dart';

final placeLatLngFetcherNotifierProvider = StateNotifierProvider<PlaceLatLngFetcherNotifier, AsyncValue<LatLng?>>(
    (ref) => PlaceLatLngFetcherNotifier(ref: ref, googleAPIRepo: ref.read(googleAPIRepoProvider)));
