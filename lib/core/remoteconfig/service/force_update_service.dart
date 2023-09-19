import 'package:amaz_corp_mobile/core/remoteconfig/entity/apk_version_entity.dart';
import 'package:amaz_corp_mobile/core/remoteconfig/repository/remote_remoteconfig_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'force_update_service.g.dart';

class ForceUpdateService {
  ForceUpdateService(this.ref);
  final Ref ref;

  Future<bool> needForceUpdate() async {
    try {
      Future<APKVersion> remote =
          ref.read(remoteRemoteconfigRepoProvider).getAPKVersion();
      Future<PackageInfo> local = PackageInfo.fromPlatform();
      List<Future> futures = [
        remote,
        local,
      ];
      final versions = await Future.wait(futures);
      String remoteVersion = versions[0].apkVersion;
      String localVersion = versions[1].version;

      bool uptodate = remoteVersion.compareTo(localVersion) == 0;
      return !uptodate;
    } catch (err) {
      return false;
    }
  }
}

@Riverpod(keepAlive: true)
ForceUpdateService forceUpdateService(ForceUpdateServiceRef ref) {
  return ForceUpdateService(ref);
}

@Riverpod(keepAlive: true)
Future<bool> checkForceUpdate(CheckForceUpdateRef ref) async {
  return await ref.read(forceUpdateServiceProvider).needForceUpdate();
}
