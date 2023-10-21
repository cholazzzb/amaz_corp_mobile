import 'package:amaz_corp_mobile/db/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_dependencies.freezed.dart';
part 'app_dependencies.g.dart';

@Riverpod(keepAlive: true)
Future<AppDependencies> appDependencies(AppDependenciesRef ref) async {
  return AppDependencies(database: Database());
}

@freezed
class AppDependencies with _$AppDependencies {
  const factory AppDependencies({
    required Database database,
  }) = _AppDependencies;
}
