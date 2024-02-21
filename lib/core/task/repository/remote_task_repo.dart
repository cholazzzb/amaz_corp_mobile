import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/repository/http_remote_task_repo.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/shared/api/dio_factory.dart';
import 'package:amaz_corp_mobile/shared/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_task_repo.g.dart';

abstract class RemoteTaskRepoQuery {
  Future<List<Task>> getListTaskByScheduleID(String scheduleID);
}

abstract class RemoteTaskRepoCommand {
  Future<void> postAddTask(AddTaskReq req);
  Future<void> putEditTask(String taskID, AddTaskReq req);
}

@riverpod
HttpRemoteTaskRepo remoteTaskRepo(
  RemoteTaskRepoRef ref,
) {
  final baseUrl = Environment.getBaseUrl();
  final localUserRepo = ref.watch(localUserRepoProvider);

  return HttpRemoteTaskRepo(
    DioFactory(
      baseUrl: baseUrl,
    ).create(localUserRepo: localUserRepo),
  );
}
