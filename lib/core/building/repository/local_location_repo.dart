import 'package:amaz_corp_mobile/app_dependencies.dart';
import 'package:amaz_corp_mobile/core/building/repository/fss_location_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_location_repo.g.dart';

abstract class LocalBuildingRepo
    implements LocalBuildingRepoCommand, LocalBuildingRepoQuery {}

abstract class LocalBuildingRepoCommand {
  Future<void> setActiveBuildingID(String buildingID);
}

abstract class LocalBuildingRepoQuery {
  Future<String> getActiveBuildingID();
}

@Riverpod(keepAlive: true)
LocalBuildingRepo localBuildingRepo(LocalBuildingRepoRef ref) {
  final fssDB = ref.watch(appDependenciesProvider).requireValue.fssDB;
  return FssLocationRepo(storage: fssDB);
}
