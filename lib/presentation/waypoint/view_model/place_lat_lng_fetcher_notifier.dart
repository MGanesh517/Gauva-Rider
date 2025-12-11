import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/repositories/interfaces/way_point_repo_interface.dart';

class PlaceLatLngFetcherNotifier extends StateNotifier<AsyncValue<LatLng>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;

  PlaceLatLngFetcherNotifier({
    required this.googleAPIRepo,
    required this.ref,
  }) : super(const AsyncValue.loading());

  Future<LatLng?> getLatLngFromPlaceId(String placeId) async {
    try {
      state = const AsyncValue.loading();
      final result = await googleAPIRepo.getLatLngFromPlaceId(placeId);
      return result.fold(
        (error) {
          state = AsyncValue.error(error.message, StackTrace.current);
          return null;
        },
        (data) {
          state = AsyncValue.data(data);
          return data;
        },
      );
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
      return null;
    }
  }
}
