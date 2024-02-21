import 'package:amaz_corp_mobile/core/building/repository/local_location_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum FssLocationKey {
  buildingID,
}

class FssLocationRepo implements LocalBuildingRepo {
  final FlutterSecureStorage storage;

  FssLocationRepo({required this.storage});

  @override
  Future<String> getActiveBuildingID() async {
    return await storage.read(key: FssLocationKey.buildingID.name) ?? "";
  }

  @override
  Future<void> setActiveBuildingID(
    String buildingID,
  ) async {
    await storage.write(
      key: FssLocationKey.buildingID.name,
      value: buildingID,
    );
  }
}
