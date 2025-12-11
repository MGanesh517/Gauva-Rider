import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../view_model/picked_address_fetcher_notifier.dart';
import 'google_api_providers.dart';

final pickedAddressFetcherNotifierProvider =
    StateNotifierProvider.family<PickedAddressFetcherNotifier, AsyncValue<String>, LatLng>((ref, latLng) => PickedAddressFetcherNotifier(ref: ref, googleAPIRepo: ref.read(googleAPIRepoProvider), latLng: latLng));
