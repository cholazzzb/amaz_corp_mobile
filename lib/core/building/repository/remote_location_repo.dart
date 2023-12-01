import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/repository/http_remote_location_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_location_repo.g.dart';

abstract class RemoteBuildingRepoCommand {
  Future<void> postAddBuilding(
    AddBuildingReq req,
  );
  Future<void> joinBuilding(
    String name,
    String buildingID,
  );
  Future<void> leaveBuilding(
    String memberID,
    String buildingID,
  );
}

abstract class RemoteBuildingRepoQuery {
  Future<List<Building>> getAllLocations();
  Future<List<BuildingMember>> getMyLocations(String memberID);
  Future<List<Member>> getListMemberByBuildingID(String buildingID);
  Future<List<Room>> getListRoomsByBuildingID(String buildingID);
}

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
