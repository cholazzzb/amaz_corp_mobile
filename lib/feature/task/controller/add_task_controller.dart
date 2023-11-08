import 'package:amaz_corp_mobile/core/task/entity/task_entity.dart';
import 'package:amaz_corp_mobile/core/task/service/task_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_task_controller.g.dart';

@riverpod
class AddTaskController extends _$AddTaskController {
  @override
  FutureOr<void> build() {}

  Future<void> addTask({
    required AddTaskReq req,
    VoidCallback? onSuccess,
  }) async {
    state = const AsyncValue.loading();

    try {
      await _addTask(req);
      onSuccess?.call();
      state = const AsyncValue.data(null);
    } catch (err, st) {
      state = AsyncValue.error(err, st);
    }
  }

  Future<void> _addTask(AddTaskReq req) async {
    final svc = ref.read(taskServiceProvider);
    await svc.addTask(req);
  }
}
