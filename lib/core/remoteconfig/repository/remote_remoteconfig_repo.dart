import 'package:amaz_corp_mobile/core/remoteconfig/entity/apk_version_entity.dart';
import 'package:amaz_corp_mobile/core/remoteconfig/repository/http_remote_remoteconfig_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_remoteconfig_repo.g.dart';

abstract class RemoteRemoteconfigRepo {
  Future<APKVersion> getAPKVersion();
}

@riverpod
RemoteRemoteconfigRepo remoteRemoteconfigRepo(
  RemoteRemoteconfigRepoRef ref,
) {
  final baseUrl = Environment.getBaseUrl();

  return HttpRemoteRemoteconfigRepo(DioFactory(baseUrl: baseUrl).create());
}
