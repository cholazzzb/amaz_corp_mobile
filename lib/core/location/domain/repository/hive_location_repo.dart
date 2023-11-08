import 'package:amaz_corp_mobile/core/location/domain/repository/local_location_repo.dart';
import 'package:hive/hive.dart';

enum HiveBuilding {
  boxKeyBuilding,
  selectedBuildingID,
  selectedRoomID,
}

class HiveBuildingRepo
    implements LocalBuildingRepoCommand, LocalBuildingRepoQuery {
  const HiveBuildingRepo({required this.storage});

  final Box<dynamic> storage;

  @override
  void setSelectedBuildingID(String selectedBuildingID) {
    storage.put(HiveBuilding.selectedBuildingID.name, selectedBuildingID);
  }

  @override
  void setSelectedRoomID(String selectedRoomID) {
    storage.put(HiveBuilding.selectedRoomID.name, selectedRoomID);
  }

  @override
  String getSelectedBuildingID() {
    final String? res = storage.get(HiveBuilding.selectedBuildingID.name);
    if (res == null) {
      return "";
    }
    return res;
  }

  @override
  String getSelectedRoomID() {
    final String? res = storage.get(HiveBuilding.selectedRoomID.name);
    if (res == null) {
      return "";
    }
    return res;
  }
}
