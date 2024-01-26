import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/repository/http_remote_location_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_location_repo.g.dart';

abstract class RemoteBuildingRepo
    implements
        RemoteBuildingRepoCommand,
        RemoteBuildingRepoQuery,
        RemoteMemberRepoCommand,
        RemoteMemberRepoQuery {}

abstract class RemoteBuildingRepoCommand {
  Future<void> postAddBuilding(
    AddBuildingReq req,
  );
  Future<void> inviteMemberToBuilding(
    InviteMemberToBuildingReq req,
  );
  Future<void> joinBuilding(
    JoinBuildingReq req,
  );
  Future<void> leaveBuilding(
    String memberID,
    String buildingID,
  );
}

abstract class RemoteBuildingRepoQuery {
  Future<List<Building>> getAllLocations();
  Future<List<BuildingMember>> getListInvitedBuildings();
  Future<List<Building>> getListMyOwnedBuilding();
  Future<List<BuildingMember>> getMyLocations(String memberID);
  Future<List<Member>> getListMemberByBuildingID(String buildingID);
  Future<List<Room>> getListRoomsByBuildingID(String buildingID);
}

abstract class RemoteMemberRepoCommand {
  Future<void> editMemberName(RenameMemberNameReq req);
}

abstract class RemoteMemberRepoQuery {}

@riverpod
HttpRemoteLocationRepo remoteLocationRepo(
  RemoteLocationRepoRef ref,
) {
  final baseUrl = Environment.getBaseUrl();

  return HttpRemoteLocationRepo(
    DioFactory(
      baseUrl: baseUrl,
      interceptor: InterceptorType.auth,
    ).create(),
  );
}
