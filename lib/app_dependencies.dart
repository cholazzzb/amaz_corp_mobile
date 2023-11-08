import 'package:amaz_corp_mobile/core/location/domain/repository/hive_location_repo.dart';
import 'package:amaz_corp_mobile/core/location/domain/repository/local_location_repo.dart';
import 'package:amaz_corp_mobile/db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_dependencies.freezed.dart';
part 'app_dependencies.g.dart';

@Riverpod(keepAlive: true)
Future<AppDependencies> appDependencies(AppDependenciesRef ref) async {
  HiveBuildingRepo locationRepo =
      await ref.watch(hiveBuildingRepoProvider.future);
  return AppDependencies(database: Database(locationRepo: locationRepo));
}

@freezed
class AppDependencies with _$AppDependencies {
  const factory AppDependencies({
    required Database database,
  }) = _AppDependencies;
}
