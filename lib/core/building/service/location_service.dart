import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/repository/hive_location_repo.dart';
import 'package:amaz_corp_mobile/core/building/repository/local_location_repo.dart';
import 'package:amaz_corp_mobile/core/building/repository/remote_location_repo.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

class LocationService {
  final Ref ref;

  LocationService(this.ref);

  Future<void> addBuilding(AddBuildingReq req) async {
    final repo = ref.read(remoteLocationRepoProvider);
    await repo.postAddBuilding(req);
  }

  Future<void> inviteMemberToBuilding(InviteMemberToBuildingReq req) async {
    final repo = ref.read(remoteLocationRepoProvider);
    await repo.inviteMemberToBuilding(req);
  }

  Future<void> renameMemberName(RenameMemberNameReq req) async {
    final repo = ref.read(remoteLocationRepoProvider);
    await repo.editMemberName(req);
  }

  Future<void> joinBuilding(
    String memberID,
    String buildingID,
  ) async {
    JoinBuildingReq req =
        JoinBuildingReq(memberID: memberID, buildingID: buildingID);
    await ref.read(remoteLocationRepoProvider).joinBuilding(req);
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
    final localUserRepo = ref.watch(localUserRepoProvider);
    final memberId = await localUserRepo.getMemberId();
    final res =
        await ref.read(remoteLocationRepoProvider).getMyLocations(memberId);
    return res;
  }

  Future<List<Member>> getListMemberByName(
    String name,
  ) async {
    final req = GetListMemberByNameReq(name: name);
    return await ref
        .read(remoteLocationRepoProvider)
        .getListMemberByBuildingID(name); // TODO: Fix HERE!
    // move to user domain
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
  return await ref.read(remoteLocationRepoProvider).getAllLocations();
}

@riverpod
Future<List<BuildingMember>> getListInvitedBuildings(
  GetListInvitedBuildingsRef ref,
) async {
  return await ref.read(remoteLocationRepoProvider).getListInvitedBuildings();
}

@riverpod
Future<List<Building>> getListMyOwnedBuildings(
  GetListMyOwnedBuildingsRef ref,
) async {
  return await ref.read(remoteLocationRepoProvider).getListMyOwnedBuilding();
}

@riverpod
Future<List<BuildingMember>> getMyLocations(GetMyLocationsRef ref) async {
  return await ref.watch(locationServiceProvider).getMyLocations();
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
Future<List<Room>> getListRoom(
  GetListRoomRef ref,
) async {
  HiveBuildingRepo hbr = await ref.watch(hiveBuildingRepoProvider.future);
  String buildingID = hbr.getSelectedBuildingID();
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
