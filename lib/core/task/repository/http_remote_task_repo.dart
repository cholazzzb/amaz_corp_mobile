import 'dart:convert';

import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/repository/remote_task_repo.dart';
import 'package:dio/dio.dart';

class HttpRemoteTaskRepo implements RemoteTaskRepoQuery, RemoteTaskRepoCommand {
  const HttpRemoteTaskRepo(this._dio);

  final Dio _dio;

  @override
  Future<List<Task>> getListTaskByScheduleID(String scheduleID) async {
    String uri = 'api/v1/schedules/$scheduleID/tasks';

    final response = await _dio.get(uri);

    final List<Task> tasks = response.data["data"]!
        .map((task) => Task.fromJSON(task))
        .toList()
        .cast<Task>();

    return tasks;
  }

  @override
  Future<void> postAddTask(AddTaskReq req) async {
    String uri = 'api/v1/tasks';

    String body = json.encode(req.toJson());

    await _dio.post(uri, data: body);

    return;
  }

  @override
  Future<void> putEditTask(String taskID, AddTaskReq req) async {
    String uri = 'api/v1/tasks/$taskID';

    String body = json.encode(req.toJson());

    await _dio.post(uri, data: body);

    return;
  }
}
