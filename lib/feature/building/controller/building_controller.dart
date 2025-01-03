import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'building_controller.g.dart';

@riverpod
class AddLocationController extends _$AddLocationController {
  @override
  FutureOr<void> build() {}

  Future<void> addBuilding({
    required AddBuildingReq req,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _addBuilding(req);
      onSuccess?.call();
      state = const AsyncValue.data(null);
    } catch (err, st) {
      state = AsyncValue.error(err, st);
    }
  }

  Future<void> _addBuilding(AddBuildingReq req) async {
    final svc = ref.read(locationServiceProvider);
    await svc.addBuilding(req);
  }
}

@riverpod
class JoinBuildingController extends _$JoinBuildingController {
  @override
  FutureOr<void> build() => Future.value();

  Future<void> joinBuilding({
    required String memberID,
    required String buildingID,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _joinBuilding(memberID, buildingID);
      onSuccess?.call();
    });
  }

  Future<void> _joinBuilding(String memberID, String buildingID) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.joinBuilding(memberID, buildingID);
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

@riverpod
class CreateRoomController extends _$CreateRoomController {
  @override
  Future<void> build() => Future.value();

  Future<void> createRoom({
    required String roomName,
    required String buildingID,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _createRoom(roomName, buildingID);
      onSuccess?.call();
    });
  }

  Future<void> _createRoom(String roomName, String buildingID) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.createRoom(
      CreateRoomReq(name: roomName, buildingID: buildingID),
    );
  }
}
