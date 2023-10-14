import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/repository/remote_task_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_service.g.dart';

class TaskService {
  TaskService(this.ref);
  final Ref ref;
}

@Riverpod(keepAlive: true)
TaskService taskService(TaskServiceRef ref) {
  return TaskService(ref);
}

@riverpod
Future<List<Task>> getListTaskByScheduleID(
  GetListTaskByScheduleIDRef ref,
  String scheduleID,
) async {
  return await ref
      .watch(remoteTaskRepoProvider)
      .getListTaskByScheduleID(scheduleID);
}
