import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/repository/remote_task_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_service.g.dart';

class TaskService {
  final Ref ref;

  TaskService(this.ref);

  Future<void> addTask(AddTaskReq req) async {
    final repo = ref.read(remoteTaskRepoProvider);
    await repo.postAddTask(req);
  }
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
