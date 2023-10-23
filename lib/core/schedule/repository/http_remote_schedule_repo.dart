import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:amaz_corp_mobile/core/schedule/entity/schedule_entity.dart';
import 'package:amaz_corp_mobile/core/schedule/repository/remote_schedule_repo.dart';

class HttpRemoteScheduleRepo
    implements RemoteScheduleRepoQuery, RemoteScheduleRepoCommand {
  const HttpRemoteScheduleRepo(this._dio);

  final Dio _dio;

  @override
  Future<List<Schedule>> getListScheduleByRoomID(String roomID) async {
    String uri = 'api/v1/schedules/rooms/$roomID';

    final response = await _dio.get(uri);

    final List<Schedule> schedules = response.data["data"]!
        .map((sch) => Schedule.fromJSON(sch))
        .toList()
        .cast<Schedule>();
    return schedules;
  }

  @override
  Future<void> addSchedule(AddScheduleReq req) async {
    String uri = 'api/v1/schedules';

    String body = json.encode(req.toJson());

    await _dio.post(uri, data: body);

    return;
  }
}
