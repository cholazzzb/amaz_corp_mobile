import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/repository/remote_location_repo.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

class LocationService {
  LocationService(this.ref);
  final Ref ref;

  Future<void> joinBuilding(
    String name,
    String buildingID,
  ) async {
    await ref.read(remoteLocationRepoProvider).joinBuilding(name, buildingID);
    return;
  }

  Future<void> leaveBuilding(
    String memberID,
    String buildingID,
  ) async {
    await ref
        .read(remoteLocationRepoProvider)
        .leaveBuilding(memberID, buildingID);
    return;
  }

  Future<List<BuildingMember>> getMyLocations() async {
    try {
      final localUserRepo = ref.watch(localUserRepoProvider);
      final memberId = await localUserRepo.getMemberId();
      final res =
          await ref.read(remoteLocationRepoProvider).getMyLocations(memberId);
      return res;
    } on Exception {
      return [];
    }
  }
}

@Riverpod(keepAlive: true)
LocationService locationService(LocationServiceRef ref) {
  return LocationService(ref);
}

@riverpod
Future<List<Building>> getAllLocations(
  GetAllLocationsRef ref,
) async {
  try {
    return await ref.read(remoteLocationRepoProvider).getAllLocations();
  } on Exception {
    return [];
  }
}

@riverpod
Future<List<BuildingMember>> getMyLocations(GetMyLocationsRef ref) async {
  try {
    return await ref.read(locationServiceProvider).getMyLocations();
  } on Exception {
    return [];
  }
}

@riverpod
Future<List<Room>> getListRoomsByBuildingID(
  GetListRoomsByBuildingIDRef ref,
  String buildingID,
) async {
  return await ref
      .read(remoteLocationRepoProvider)
      .getListRoomsByBuildingID(buildingID);
}

@riverpod
Future<List<Member>> getListMemberByBuildingID(
  GetListMemberByBuildingIDRef ref,
  String buildingID,
) async {
  return await ref
      .read(remoteLocationRepoProvider)
      .getListMemberByBuildingID(buildingID);
}
