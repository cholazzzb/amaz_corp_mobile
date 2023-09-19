import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/repository/http_remote_location_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_location_repo.g.dart';

abstract class RemoteLocationRepo {
  Future<List<Building>> getAllLocations();
  Future<Either<Exception, bool>> joinBuilding(
    String memberId,
    String buildingId,
  );
  Future<Either<Exception, bool>> leaveBuilding(
    String memberId,
    String buildingId,
  );
  Future<List<Building>> getMyLocations(String memberId);
}

@riverpod
RemoteLocationRepo remoteLocationRepo(
  RemoteLocationRepoRef ref,
) {
  final baseUrl = Environment.getBaseUrl();

  return HttpRemoteLocationRepo(
    DioFactory(
      baseUrl: baseUrl,
      interceptor: InterceptorType.auth,
    ).create(),
  );
}
