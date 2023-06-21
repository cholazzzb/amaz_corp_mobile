import 'package:amaz_corp_mobile/core/location/domain/repository/http_remote_location_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_location_repo.g.dart';

abstract class RemoteLocationRepo {
  Future<int> getAllLocations();
}

@riverpod
RemoteLocationRepo remoteLocationRepo(
  RemoteLocationRepoRef ref,
) {
  return HttpRemoteLocationRepo(
    DioFactory(
      baseUrl: 'https://amaz-corp-be-staging.onrender.com/',
      interceptor: InterceptorType.auth,
    ).create(),
  );
}
