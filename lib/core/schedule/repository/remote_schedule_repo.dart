import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/core/schedule/repository/http_remote_schedule_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_schedule_repo.g.dart';

abstract class RemoteScheduleRepoQuery {
  Future<List<Schedule>> getListScheduleByRoomID(String roomID);
}

@riverpod
HttpRemoteScheduleRepo remoteScheduleRepo(
  RemoteScheduleRepoRef ref,
) {
  final baseUrl = Environment.getBaseUrl();

  return HttpRemoteScheduleRepo(
    DioFactory(
      baseUrl: baseUrl,
      interceptor: InterceptorType.auth,
    ).create(),
  );
}
