import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.g.dart';

@riverpod
class LocationController extends _$LocationController {
  @override
  FutureOr<void> build() {}

  Future<void> joinBuilding({
    required String name,
    required String buildingID,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _joinBuilding(name, buildingID);
      onSuccess?.call();
      state = const AsyncValue.data(null);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> _joinBuilding(String name, String buildingId) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.joinBuilding(name, buildingId);
  }

  Future<void> leaveBuilding({
    required String memberId,
    required String buildingId,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _leaveBuilding(memberId, buildingId).then(
        (value) {
          onSuccess?.call();
          return value;
        },
      ),
    );
  }

  Future<void> _leaveBuilding(String memberId, String buildingId) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.leaveBuilding(memberId, buildingId);
  }
}
