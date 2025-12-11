import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/repositories/interfaces/way_point_repo_interface.dart';

class PickedAddressFetcherNotifier extends StateNotifier<AsyncValue<String>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;
  final LatLng latLng;
  PickedAddressFetcherNotifier({required this.ref, required this.googleAPIRepo, required this.latLng})
    : super(const AsyncLoading()) {
    getAddressFromLatLng(latLng);
  }

  Future<String?> getAddressFromLatLng(LatLng latLng) async {
    state = const AsyncLoading();
    final address = await googleAPIRepo.getAddressFromLatLng(latLng);
    state = address.fold((error) => AsyncError(error, StackTrace.current), (data) => AsyncValue.data(data));
    return state.value;
  }
}
