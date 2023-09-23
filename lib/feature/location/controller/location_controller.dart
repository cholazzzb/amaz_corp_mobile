import 'package:amaz_corp_mobile/core/location/domain/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.g.dart';

@riverpod
class JoinBuildingController extends _$JoinBuildingController {
  @override
  FutureOr<void> build() => Future.value();

  Future<void> joinBuilding({
    required String name,
    required String buildingID,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _joinBuilding(name, buildingID);
      onSuccess?.call();
    });
  }

  Future<void> _joinBuilding(String name, String buildingId) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.joinBuilding(name, buildingId);
  }
}

@riverpod
class LeaveBuildingController extends _$LeaveBuildingController {
  @override
  Future<void> build() => Future.value();

  Future<void> leaveBuilding({
    required String memberId,
    required String buildingId,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _leaveBuilding(memberId, buildingId);
      onSuccess?.call();
    });
  }

  Future<void> _leaveBuilding(String memberId, String buildingId) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.leaveBuilding(memberId, buildingId);
  }
}
