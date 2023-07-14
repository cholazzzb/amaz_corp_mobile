import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.g.dart';

@riverpod
class LocationController extends _$LocationController {
  @override
  FutureOr<void> build() {}

  Future<void> joinBuilding({
    required String memberId,
    required String buildingId,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _joinBuilding(memberId, buildingId).then(
        (value) {
          onSuccess?.call();
          return value;
        },
      ),
    );
  }

  Future<void> _joinBuilding(String memberId, String buildingId) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.joinBuilding(memberId, buildingId);
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
