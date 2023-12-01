import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'building_service.g.dart';

class BuildingService {
  BuildingService(this.ref);
  final Ref ref;

  void updateSelectedBuilding(
    String activeBuildingID,
  ) {
    LocalUserRepo repo = ref.watch(localUserRepoProvider);
    repo.setActiveBuildingID(activeBuildingID);
  }
}

@Riverpod(keepAlive: true)
BuildingService buildingService(BuildingServiceRef ref) {
  return BuildingService(ref);
}

@riverpod
Future<(String, List<BuildingMember>)> getMyBuildings(
  GetMyBuildingsRef ref,
) async {
  LocalUserRepo localUserRepo = ref.watch(localUserRepoProvider);
  final activeBuildingID = await localUserRepo.getActiveBuildingID();
  final myLocations = await ref.watch(getMyLocationsProvider.future);
  if (activeBuildingID.isEmpty && myLocations.isNotEmpty) {
    await localUserRepo.setActiveBuildingID(myLocations[0].id);
  }
  final selectedBuildingID = switch ((
    activeBuildingID,
    myLocations.isNotEmpty,
  )) {
    ("", true) => myLocations[0].id,
    (_, _) => activeBuildingID,
  };
  return Future(() => (selectedBuildingID, myLocations));
}
