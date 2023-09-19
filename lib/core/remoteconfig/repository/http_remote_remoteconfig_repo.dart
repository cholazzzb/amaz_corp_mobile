import 'package:amaz_corp_mobile/core/remoteconfig/entity/apk_version_entity.dart';
import 'package:amaz_corp_mobile/core/remoteconfig/repository/remote_remoteconfig_repo.dart';
import 'package:dio/dio.dart';

class HttpRemoteRemoteconfigRepo implements RemoteRemoteconfigRepo {
  const HttpRemoteRemoteconfigRepo(this._dio);

  final Dio _dio;

  @override
  Future<APKVersion> getAPKVersion() async {
    const uri = 'api/v1/remoteconfig/apk-version';
    try {
      final response = await _dio.get(uri);
      final APKVersion apkVersion = APKVersion.fromJSON(response.data["data"]);

      return apkVersion;
    } catch (err) {
      return const APKVersion(apkVersion: '2');
    }
  }
}
