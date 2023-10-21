import 'package:amaz_corp_mobile/core/location/domain/repository/hive_location_repo.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_location_repo.g.dart';

abstract class LocalBuildingRepoCommand {
  void setSelectedBuildingID(String selectedBuildingID);
  void setSelectedRoomID(String selectedRoomID);
}

abstract class LocalBuildingRepoQuery {
  String getSelectedBuildingID();
  String getSelectedRoomID();
}

@Riverpod(keepAlive: true)
Future<HiveBuildingRepo> hiveBuildingRepo(HiveBuildingRepoRef ref) async {
  final storage = await Hive.openBox(HiveBuilding.boxKeyBuilding.name);
  return HiveBuildingRepo(storage: storage);
}
