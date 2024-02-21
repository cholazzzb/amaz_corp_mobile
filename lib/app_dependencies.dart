import 'package:amaz_corp_mobile/db.dart';
import 'package:amaz_corp_mobile/shared/fss_db.dart';
import 'package:amaz_corp_mobile/shared/isar_db.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_dependencies.freezed.dart';
part 'app_dependencies.g.dart';

@Riverpod(keepAlive: true)
Future<AppDependencies> appDependencies(AppDependenciesRef ref) async {
  final fssDB = ref.watch(fssDBProvider);

  final isar = await ref.watch(isarDBProvider.future);

  return AppDependencies(
    fssDB: fssDB,
    database: Database(isar: isar),
  );
}

@freezed
class AppDependencies with _$AppDependencies {
  const factory AppDependencies({
    required FlutterSecureStorage fssDB,
    required Database database,
  }) = _AppDependencies;
}
